//
//  IceLakeModel.swift
//  test
//
//  Created by Newshutz, William D on 11/3/17.
//  Copyright © 2017 Newshutz, William D. All rights reserved.
//

import Foundation


//To create the model call IceLakeModel()
//To load a level call loadLevel(Int), getMazeSize(), getObstacles(), getPlayer(), getVictoryLocation()
//To attempt a move call move(Int, Int, Direction), and didPlayerWin()
class IceLakeModel {
    
    //The Struct that holds the level data
    private let iceLakeLevels = IceLakeLevels()
    
    //The variable to hold the maze once loaded
    //The  maze must be an array of X arrays that are each exactly X long (an X by X array)
    private var maze: [[Int?]]? = nil
    private var mazeSize: Int? = nil
    
    //The variable to hold if the player won
    private var playerWon = false
    
    
    //An enum provided for interfacing with this model in order to validate input by limiting movement to 4 directions.
    enum Direction {
        case up
        case right
        case down
        case left
    }
    
    //An english language enum for better self documenting code
    enum ObjectTypes {
        case empty
        case obstacle
        case player
        case exit
    }
    
    //A dictionary to translate between the primitive storage and the english language enum
    private let objectEncoding: Dictionary<Int,ObjectTypes> = [
        0 : .empty,
        1 : .obstacle,
        2 : .player,
        3 : .exit
    ]
    
    init() {
        if(loadLevel(levelNum: 1)) {
            //The level loaded fine
        }
        else {
            //The level did not load
        }
    }
    
    init(levelNum : Int) {
        if (loadLevel(levelNum: levelNum)) {
            //The level loaded fine
        }
        else {
            //The level did not load
        }
        
    }
    
    
    //When passed an integer levelNum it will prepare the corresponding level data or prepare the first level
    //Returns true if a level data was loaded, else returns false
    /*mutating*/ func loadLevel(levelNum: Int) -> Bool {
        maze = iceLakeLevels.getLevelData(levelNum: levelNum)
        if (maze != nil)
        {
            mazeSize = maze!.count
            playerWon = false
            return true
        }
        return false
    }
    
    //Returns the number of spaces in either direction of the X by X maze
    func getMazeSize() -> Int?{
        if (maze != nil && mazeSize != nil)
        {
            return mazeSize
        }
        return  nil
    }
    
    //Returns an array listing the X,Y indexes of objects of that type
    private func getObjects(type: ObjectTypes) -> [Int]? {
        var objects: [Int] = []
        
        if (maze != nil && mazeSize != nil)
        {
            for xIndex in 0..<mazeSize! {
                for yIndex in 0..<mazeSize! {
                    if let obj = maze?[xIndex][yIndex]{
                        //if obj != nil {
                        if objectEncoding[obj] == type {
                            objects.append(xIndex)
                            objects.append(yIndex)
                        }
                        //}
                    }
                }
            }
            return objects
        }
        
        return  nil
    }
    
    //
    func getObstacles() -> [Int]? {
        return getObjects(type: ObjectTypes.obstacle)
    }
    
    //
    func getPlayer() -> [Int]? {
        return getObjects(type: ObjectTypes.player)
    }
    
    //
    func getVictoryLocation() -> [Int]? {
        return getObjects(type: ObjectTypes.exit)
    }
    
    //
    /*mutating*/ func moveObject(atX: Int, atY: Int, direction: Direction) -> [Int]?{
        //set direction
        
        var xOffset = 0
        var yOffset = 0
        
        switch direction
        {
        case .up:
            yOffset = -1
        case .right:
            xOffset = 1
        case .down:
            yOffset = 1
        case .left:
            xOffset = -1
        }
        
        
        //if maze exists
        if (maze != nil && mazeSize != nil) {
            
            //if valid index
            if (atX >= 0 && atX < mazeSize! && atY >= 0 && atY < mazeSize!){
                
                //if a moveable object is at that location
                if let objectCode = maze?[atX][atY] {
                    if let object = objectEncoding[objectCode] {
                        if object == ObjectTypes.player
                        {
                            //attempt recursive movement
                            return move(atX: atX, atY: atY, xOffset: xOffset, yOffset: yOffset)
                        }
                    }
                }
            }
        }
        
        //return no location if unable to moveObject
        return nil
    }
    
    //Called only if the maze exists, and we are focused on a moveable object inside the maze
    //Recursively tries to move the object in that direction and returns the final position
    private /*mutating*/ func move(atX: Int, atY: Int, xOffset: Int, yOffset: Int) -> [Int]
    {
        //Validate new index
        let newX = atX+xOffset
        let newY = atY+yOffset
        if (newX >= 0 && newX < mazeSize! && newY >= 0 && newY < mazeSize!) {
            
            //Is new location empty or a exit space?
            if let objectCode = maze?[newX][newY] {
                if let object = objectEncoding[objectCode] {
                    switch object {
                    case .empty:
                        //move object to new space
                        maze?[newX][newY] = maze?[atX][atY]
                        //replace object at old space with empty
                        maze?[atX][atY] = 0
                        
                        //check more movement and return final location
                        return move(atX: newX, atY: newY, xOffset: xOffset, yOffset: yOffset)
                        
                    case .exit:
                        playerWon = true
                        
                        //move object to new space
                        maze?[newX][newY] = maze?[atX][atY]
                        //replace object at old space with empty
                        maze?[atX][atY] = 0
                        
                        //Return final location
                        return [newX,newY]
                        
                    default:
                        //Return the same location if the moveable object cannot be moved
                        return [atX,atY]
                    }
                }
            }
            
        }
        
        //Return the same location if the moveable object cannot be moved
        return [atX,atY]
    }
    
    //Returns true if the player has moved into the exit at any time this level. Else returns false.
    func didPlayerWin() -> Bool {
        return playerWon
    }
}
