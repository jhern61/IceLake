//
//  GameViewController.swift
//  Practice
//
//  Created by Hernandez, Joe on 11/7/17.
//  Copyright © 2017 Hernandez, Joe. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private var model : IceLakeModel? = nil
    private var obstacles : [CGPoint] = []
    private var playerLocation : CGPoint? = nil
    private var victoryLocation : CGPoint? = nil
    private var gameSceneRect : CGRect? = nil
    var levelNum : Int = 1
    
    
    func getObstacles() -> [CGPoint] {
        return obstacles
    }
    
    func getPlayerLocation() -> CGPoint? {
        return playerLocation
    }
    
    func getVictoryLocation() -> CGPoint? {
        return victoryLocation
    }
    
    //Swipe user gesture will call something like this
    func move(from : CGPoint, inRect : CGRect, towards: IceLakeModel.Direction) -> CGPoint?{
        
        gameSceneRect = inRect
        
        if let startPoint = convertCGPointToXY(from) {
            print("from \(startPoint)")
            if let endPoint = model?.moveObject(atX: startPoint[0], atY: startPoint[1], direction: towards) {
                print("to \(endPoint)")
                if (startPoint != endPoint) { //this seems wrong but works in swift?
                    return convertXYtoCGPoint(atX: endPoint[0], atY: endPoint[1])
                    
                }
            }
        }
        return nil
    }
    
    func checkVictory() {
        if let victory = model?.didPlayerWin() {
            if victory {
                
                //Send out an alert telling them they won
                let alert = UIAlertController(title: "You won", message: "Try the next level", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                //End sending out alert
                
                //change level
                levelNum += 1
                if levelNum > 9 {
                    levelNum = 1
                }
                if (model?.loadLevel(levelNum: levelNum))! {
                    //reload level view
                    if let view = self.view as! SKView? {
                        // Load the SKScene from 'GameScene.sks'
                        if let scene = GameScene(fileNamed: "GameScene") {
                            // Set the scale mode to scale to fit the window
                            scene.scaleMode = .aspectFill
                            
                            scene.gameViewController = self
                            
                            // Present the scene
                            view.presentScene(scene)
                        }
                        
                        //Show stats
                        view.ignoresSiblingOrder = true
                        view.showsFPS = false
                        view.showsNodeCount = false
                    }
                }
            }
            
        }
        
        
    }
    
    func loadModel(levelNum: Int) {
        model = IceLakeModel(levelNum: levelNum)
    }
    
    
    //This Method instantiates a level in the model and passes the locations of the objects involved
    func changeLevel(levelNum: Int, inRect: CGRect) {
        if (model != nil) {
            if(model!.loadLevel(levelNum: levelNum)) {
                loadLevel(inRect: inRect)
            }
        }
    }
    
    //One of these methods depending on implementation
    func loadLevel(inRect: CGRect) {
        if (model != nil) {
            
            gameSceneRect = inRect
            
            obstacles = []
            if let obstacleInts = model!.getObstacles() {
                let obstacleCount = obstacleInts.count
                for index in 0..<obstacleCount/2 {
                    obstacles.append(convertXYtoCGPoint(atX: obstacleInts[2 * index], atY: obstacleInts[1 + 2 * index])!)
                }
            }
            
            let playerInt = model!.getPlayer()
            playerLocation = convertXYtoCGPoint(atX: playerInt?[0], atY: playerInt?[1])
            let victoryInt = model!.getVictoryLocation()
            victoryLocation = convertXYtoCGPoint(atX: victoryInt?[0], atY: victoryInt?[1])
        }
    }
    
    
    
    //These coversions should be reasonable but need to be broken into steps and validated with "if let" and similar
    private func convertCGPointToXY(_ point: CGPoint) -> [Int]? {
        
        if (gameSceneRect != nil) {
            if(model != nil) {
                if let mazeSize = model?.getMazeSize() {
                    let atX = Int((point.x - (gameSceneRect?.minX)!) / ((gameSceneRect?.maxX)! - (gameSceneRect?.minX)!) * CGFloat(mazeSize))
                    let atY = Int((point.y - (gameSceneRect?.minY)!) / ((gameSceneRect?.maxY)! - (gameSceneRect?.minY)!) * CGFloat(mazeSize))
                    return [atX,atY]
                }
            }
        }
        return nil
    }
    
    private func convertXYtoCGPoint(atX: Int?, atY: Int?) -> CGPoint?{
        
        if (atX != nil && atY != nil) {
            if (gameSceneRect != nil) {
                if let mazeSize = model?.getMazeSize() {
                    let xFloat = gameSceneRect!.minX + (CGFloat(atX!) / CGFloat(mazeSize) * (gameSceneRect!.maxX - gameSceneRect!.minX))
                    let yFloat = gameSceneRect!.minY + (CGFloat(atY!) / CGFloat(mazeSize) * (gameSceneRect!.maxY - gameSceneRect!.minY))
                    
                    return CGPoint(x: xFloat, y: yFloat)
                }
            }
        }
        return nil
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = GameScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                scene.gameViewController = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            //Show stats
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    //Hide hidden bar (hide time)
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}
