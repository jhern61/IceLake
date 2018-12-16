//
//  TransitionViewController.swift
//  Ice Lake
//
//  Created by Newshutz, William D on 11/23/17.
//  Copyright © 2017 Hernandez, Joe. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {
    
    var levelNum : Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination;
        
        if let gameViewController = destinationViewController as? GameViewController {
            //Identifier -> Level loading
            if (levelNum != nil) {
                gameViewController.levelNum = levelNum!
                gameViewController.loadModel(levelNum: levelNum!)
            }
            else {
                gameViewController.levelNum = 1
                gameViewController.loadModel(levelNum: 1)
            }
        }
    }
    
}
