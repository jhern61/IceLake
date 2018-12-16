//
//  GameScene.swift
//  Ice Maze
//
//  Created by Hernandez, Joe on 10/31/17.
//  Copyright © 2017 Hernandez, Joe. All rights reserved.
//

import SpriteKit
import GameplayKit


class GameScene: SKScene, SKPhysicsContactDelegate{
    
    
    
    //PLayer variable
    var player = SKSpriteNode()
    var playerColor = UIColor.black
    var playerSize = CGSize(width: 30, height: 30)
    var touchLocation = CGPoint()
    
    //Swipe gestures
    let swipeRightRec = UISwipeGestureRecognizer()
    let swipeLeftRec = UISwipeGestureRecognizer()
    let swipeUpRec = UISwipeGestureRecognizer()
    let swipeDownRec = UISwipeGestureRecognizer()
    
    //Delete gestures
    override func willMove(from view: SKView) {
        if view.gestureRecognizers != nil {
            for gesture in view.gestureRecognizers! {
                if let recognizer = gesture as? UISwipeGestureRecognizer {
                    view.removeGestureRecognizer(recognizer)
                    
                }
            }
        }
    }
    
    
    //The gameViewController that controlls the game
    weak var gameViewController : GameViewController?
    
    //Smaller Map
    var smallRect : CGRect {
        get {
            
           return CGRect(x: self.frame.minX + (self.frame.width / 2) - min(self.frame.width, self.frame.height) * 3 / 8,
                        y: self.frame.minY + (self.frame.height / 2) - min(self.frame.width, self.frame.height) * 3 / 8,
                        width: min(self.frame.width, self.frame.height) * 3 / 4,
                        height: min(self.frame.width, self.frame.height) * 3 / 4)
        }
    }
    
    override func didMove(to view: SKView) {
        //Spawn objects
        gameViewController?.loadLevel(inRect: smallRect)
        spawnPlayer()
        spawnVictoryLocation()
        spawnObstacles()
        
        
        //Swipe Right
        swipeRightRec.addTarget(self, action: #selector(GameScene.swipeRight))
        swipeRightRec.direction = .right
        self.view?.addGestureRecognizer(swipeRightRec)
        
        //Swipe Left
        swipeLeftRec.addTarget(self, action: #selector(GameScene.swipeLeft))
        swipeLeftRec.direction = .left
        self.view?.addGestureRecognizer(swipeLeftRec)
        
        //Swipe Up
        swipeUpRec.addTarget(self, action: #selector(GameScene.swipeUp))
        swipeUpRec.direction = .up
        self.view?.addGestureRecognizer(swipeUpRec)
        
        //Swipe Down
        swipeDownRec.addTarget(self, action: #selector(GameScene.swipeDown))
        swipeDownRec.direction = .down
        self.view?.addGestureRecognizer(swipeDownRec)
        
        
        
    }
    
    //
    //MARK: =====   MOVING FUNCTIONS
    //
    
    func swipeRight(){
        if (gameViewController != nil) {
            let newPosition = gameViewController!.move(from : player.position, inRect: smallRect, towards: IceLakeModel.Direction.right)
            if (newPosition != nil) {
                player.position = newPosition!
            }
        }
        gameViewController?.checkVictory()
    }
    
    func swipeLeft(){
        if (gameViewController != nil) {
            let newPosition = gameViewController!.move(from : player.position, inRect: smallRect, towards: IceLakeModel.Direction.left)
            if (newPosition != nil) {
                player.position = newPosition!
            }
        }
        gameViewController?.checkVictory()
    }
    
    func swipeUp(){
        if (gameViewController != nil) {
            let newPosition = gameViewController!.move(from : player.position, inRect: smallRect, towards: IceLakeModel.Direction.down)//counter intuitive but true
            if (newPosition != nil) {
                player.position = newPosition!
            }
        }
        gameViewController?.checkVictory()
    }
    
    func swipeDown(){
        if (gameViewController != nil) {
            let newPosition = gameViewController!.move(from : player.position, inRect: smallRect, towards: IceLakeModel.Direction.up)//counter intuitive but true
            if (newPosition != nil) {
                player.position = newPosition!
            }
        }
        gameViewController?.checkVictory()
    }
    
    
    //
    ///MARK: ====  SPAWNING FUNCTIONS
    //
    
    
    // MARK ==== Spawn character at a specific location
    func spawnPlayer(){
        player = SKSpriteNode(color: playerColor, size: playerSize)
        
        if let newPosition = gameViewController?.getPlayerLocation() {
            player.position = newPosition
        }
        
        //Spawn
        self.addChild(player)
    }
    
    /// MARK ==== Spawn the victory location sprite
    func spawnVictoryLocation() {
        
        //Finish Node
        let finishNodeTexture = SKTexture(imageNamed: "FInish.png")
        let finishSize = CGSize(width: 40, height: 40)
        let finishNode = SKSpriteNode(texture: finishNodeTexture, size: finishSize)
        
        //Spawn node
        self.addChild(finishNode)
        
        //Get location for where the end is suppose to be
        if let location = gameViewController?.getVictoryLocation() {
            finishNode.position = location
        }
        
    }
    
    //MARK ==== Spawn the opbstacle location sprites
    func spawnObstacles() { //-> [CGPoint] {
        
        //Create array of nodes
        var obstaclesNodes : [SKSpriteNode] = []
        
        //Get obstacles from controller
        let obstacles = gameViewController?.getObstacles()
        
        //Create obstacle nodes and give them locations
        for point in obstacles! {
           
            //Create object obstacle
            let obstacleTexture = SKTexture(imageNamed: "ice.jpg")
            let obstacleSize = CGSize(width: 70, height: 70)
            let obstacle = SKSpriteNode(texture: obstacleTexture, color: .black, size: obstacleSize)
            
            //add the obstacle to the view
            self.addChild(obstacle)
            obstacle.position = point
            obstaclesNodes.append(obstacle)
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered'
        
    }
}
