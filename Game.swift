//
//  Game.swift
//  testApp
//
//  Created by James on 1/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

class Game
{
    var theBoard :Board
    var p1 : Player
    var p2 : Player
    
 
    init()
    {
        theBoard = Board.shared()
        p1 = Player(colorChosen: Board.Slot.Red)
        p2 = Player(colorChosen: Board.Slot.Black)
    }
    
    
    
    
}