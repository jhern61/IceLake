//
//  IceLakeLevels.swift
//  test
//
//  Created by Newshutz, William D on 11/7/17.
//  Copyright © 2017 Newshutz, William D. All rights reserved.
//

import Foundation

//Levels will always be 2D arrays of X by X dimensions
struct IceLakeLevels{
    
    //0 = nothing
    //1 = obstacle
    //2 = player
    //3 = victory
    
    func getLevelData(levelNum: Int) -> [[Int?]] {
        switch levelNum {
        case 1: return level1
        case 2: return level2
        case 3: return level3
        case 4: return level4
        case 5: return level5
        case 6: return level6
        case 7: return level7
        case 8: return level8
        case 9: return level9
        default: return level1
        }
    }
    
    private let level1: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,2,0,0,1,1,1],
        [1,1,0,0,0,0,1,1],
        [1,1,0,0,0,0,1,1],
        [1,1,1,0,0,3,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1]]
    
    
    private let level2: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,3,0,1,0,1,1],
        [1,1,1,0,0,0,1,1],
        [1,1,0,0,0,0,1,1],
        [1,1,2,0,0,1,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1]]
    
    private let level3: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,0,0,1,3,1,1],
        [1,1,0,0,0,0,1,1],
        [1,1,0,0,0,1,1,1],
        [1,1,1,0,0,2,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1]]
    
    private let level4: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,0,0,1,2,1,1],
        [1,1,0,0,0,0,1,1],
        [1,1,0,3,0,0,1,1],
        [1,1,0,0,0,0,1,1],
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,1,1,1,1]]
    
    private let level5: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,2,0,1,1,1,1,1],
        [1,0,0,1,0,0,1,1],
        [1,1,0,0,0,0,0,1],
        [1,1,0,3,0,0,0,1],
        [1,0,0,0,0,1,1,1],
        [1,0,0,1,0,0,1,1],
        [1,1,1,1,1,1,1,1]]
    
    private let level6: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,1,1,1,0,0,1,1],
        [1,0,0,1,0,0,0,1],
        [1,0,0,3,0,0,0,1],
        [1,1,0,0,0,0,0,1],
        [1,0,0,0,0,1,1,1],
        [1,2,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1]]
    
    private let level7: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,1,0,0,0,1,1,1],
        [1,0,0,0,0,1,1,1],
        [1,0,0,0,0,0,0,1],
        [1,1,3,0,0,0,0,1],
        [1,1,0,0,0,0,0,1],
        [1,0,0,0,1,1,2,1],
        [1,1,1,1,1,1,1,1]]
    
    private let level8: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,0,0,0,1,0,2,1],
        [1,0,0,0,0,0,0,1],
        [1,1,0,0,0,0,1,1],
        [1,0,0,1,0,0,0,1],
        [1,0,0,0,0,0,0,1],
        [1,3,0,0,1,0,0,1],
        [1,1,1,1,1,1,1,1]]
    
    private let level9: [[Int?]] = [
        [1,1,1,1,1,1,1,1],
        [1,2,0,0,1,0,0,1],
        [1,1,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,1],
        [1,0,0,1,0,0,1,1],
        [1,0,0,0,0,0,0,1],
        [1,0,0,0,1,0,3,1],
        [1,1,1,1,1,1,1,1]]
    
    
}
