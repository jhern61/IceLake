//
//  LevelViewController.swift
//  Ice Lake
//
//  Created by Hernandez, Joe on 11/7/17.
//  Copyright © 2017 Hernandez, Joe. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
    
    
    
    //Select level with user touch
    @IBAction func touchLevelDigit(_ sender: UIButton) {
        
    }
    
    
    // MARK: - Navigation function for both LevelViewController and the yet to be created MenuViewController
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        var destinationViewController = segue.destination;
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController;
        }
        
        
        if let transitionViewController = destinationViewController as? TransitionViewController {
            if let identifier = segue.identifier {
                
                if let levelNum = Int(identifier) {
                    transitionViewController.levelNum = levelNum
                }
            }
        }
        
        if let gameViewController = destinationViewController as? GameViewController {
            if let identifier = segue.identifier {
                //Identifier -> Level loading
                if let levelNum = Int(identifier) {
                    gameViewController.loadModel(levelNum: levelNum)
                }
                else {
                    gameViewController.loadModel(levelNum: 1)
                }
            }
        }
        
    }
    
}
