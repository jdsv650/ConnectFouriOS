//
//  Board.swift
//  testApp
//
//  Created by James on 1/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

class Board
{
    enum Slot {
        case Red
        case Black
        case None
    }
    
    let rows = 6
    let cols = 7
    
    
    private struct Static {
        private static let instance: Board = Board()
    }
    
    class func shared() -> Board
    {
        return Static.instance
    }
    
    private var theBoard : [[Slot]] = [[.None, .None, .None, .None, .None, .None, .None],
                                       [.None, .None, .None, .None, .None, .None, .None],
                                       [.None, .None, .None, .None, .None, .None, .None],
                                       [.None, .None, .None, .None, .None, .None, .None],
                                       [.None, .None, .None, .None, .None, .None, .None],
                                       [.None, .None, .None, .None, .None, .None, .None]]
    
    func dropToken(#atRow: Int, andCol: Int, withSlotType: Slot) -> Bool
    {
        // row in range
        if atRow >= rows || atRow < 0
        { return false  }
        
        // col in range
        if andCol >= cols || andCol < 0
        { return false }
        
        // empty slot ?
        if theBoard[atRow][andCol] == Slot.None
        {
            theBoard[atRow][andCol] = withSlotType
            return true
        }
        
        //slot taken
        return false
    }
    
    func isFull() -> Bool
    {
        for row in theBoard {
            for col in row
            {
                if col == Slot.None
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    
    
    
    
    
    
    
    
    func clear()
    {
        theBoard = [[.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None],
        [.None, .None, .None, .None, .None, .None, .None]]
    }
    
}
