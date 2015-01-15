//
//  Board.swift
//  testApp
//
//  Created by James on 1/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation

extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}

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
        
        if theBoard[atRow][andCol] == Slot.None
        {
            theBoard[atRow][andCol] = withSlotType
            return true
        }
        
        //slot taken
        return false
    }
    
    func dropTokenAtSlotWithTagNumber(#number: Int, withSlotType: Slot) -> Bool
    {
        // empty slot ?
        // board tags
        // 11,12,13,14,15,16,17
        // 21,22,23,23,25,26,27
        // 31,32,33,34,35,36,37
        // 41,42,43,44,45,46,47
        // 51,52,53,54,55,56,57
        // 61,62,63,64,65,66,67
        
        var numAsString = "\(number)"
        var row = numAsString[0].toInt()!
        var col = numAsString[1].toInt()!

        row-- ; col--
        
        // row in range
        if row >= rows || row < 0
        { return false  }
        
        // col in range
        if col >= cols || col < 0
        { return false }
        
        // if bottom row and free take it
        if row == 5 &&  theBoard[row][col] == Slot.None
        {
            theBoard[row][col] = withSlotType
            return true
            
        } else if theBoard[row][col] == Slot.None && theBoard[row+1][col] != Slot.None
        {
          // free slot and supported by token under me -- no floating tokens
            theBoard[row][col] = withSlotType
            return true
        }
       
        // slot taken
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
    
    func getSlot(#row: Int, andCol : Int) -> Slot
    {
        return theBoard[row][andCol]
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
