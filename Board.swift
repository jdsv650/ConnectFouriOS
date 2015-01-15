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
    
    func checkWin() -> (Bool, [Int], Slot)
    {
        // 11,12,13,14,15,16,17    (-1 for index)
        // 21,22,23,23,25,26,27
        // 31,32,33,34,35,36,37
        // 41,42,43,44,45,46,47
        // 51,52,53,54,55,56,57
        // 61,62,63,64,65,66,67
        
        for i in 0...5  // 6 rows
        {
            var results = checkHorizontal(i)
            if results.0 == true
            {
                return results
            }
        }
        
        for i in 0...6  // 7 cols
        {
            var results = checkVertical(i)
            if results.0 == true
            {
                return results
            }
        }
        
        return (false, [], Slot.None)
    }
    
    
    func checkDiagonal(row :Int) -> (Bool, [Int], Slot)
    {
     
        
        return (false, [], Slot.None)
    }
    
    func checkHorizontal(row :Int) -> (Bool, [Int], Slot)
    {
        // check black
        if theBoard[row][0] == Board.Slot.Black && theBoard[row][1] == Board.Slot.Black
          && theBoard[row][2] == Board.Slot.Black && theBoard[row][3] == Board.Slot.Black
        {
            return (true, [0,1,2,3], Slot.Black)
        } else if theBoard[row][1] == Board.Slot.Black && theBoard[row][2] == Board.Slot.Black
        && theBoard[row][3] == Board.Slot.Black && theBoard[row][4] == Board.Slot.Black
        {
            return (true, [1,2,3,4], Slot.Black)
        }
        else if theBoard[row][2] == Board.Slot.Black && theBoard[row][3] == Board.Slot.Black
            && theBoard[row][4] == Board.Slot.Black && theBoard[row][5] == Board.Slot.Black
        {
            return (true, [2,3,4,5], Slot.Black)
        }
        else if theBoard[row][3] == Board.Slot.Black && theBoard[row][4] == Board.Slot.Black
            && theBoard[row][5] == Board.Slot.Black && theBoard[row][6] == Board.Slot.Black
        {
            return (true, [3,4,5,6], Slot.Black)
        }
        
        // copy paste for red
        if theBoard[row][0] == Board.Slot.Red && theBoard[row][1] == Board.Slot.Red
            && theBoard[row][2] == Board.Slot.Red && theBoard[row][3] == Board.Slot.Red
        {
            return (true, [0,1,2,3], Slot.Red)
        } else if theBoard[row][1] == Board.Slot.Red && theBoard[row][2] == Board.Slot.Red
            && theBoard[row][3] == Board.Slot.Red && theBoard[row][4] == Board.Slot.Red
        {
            return (true, [1,2,3,4], Slot.Red)
        }
        else if theBoard[row][2] == Board.Slot.Red && theBoard[row][3] == Board.Slot.Red
            && theBoard[row][4] == Board.Slot.Red && theBoard[row][5] == Board.Slot.Red
        {
            return (true, [2,3,4,5], Slot.Red)
        }
        else if theBoard[row][3] == Board.Slot.Red && theBoard[row][4] == Board.Slot.Red
            && theBoard[row][5] == Board.Slot.Red && theBoard[row][6] == Board.Slot.Red
        {
            return (true, [3,4,5,6], Slot.Red)
        }
        
        return (false, [], Slot.None)
    }
    
    
    
    func checkVertical(col :Int) -> (Bool, [Int], Slot)
    {
        // check black
        if theBoard[0][col] == Board.Slot.Black && theBoard[1][col] == Board.Slot.Black
            && theBoard[2][col] == Board.Slot.Black && theBoard[3][col] == Board.Slot.Black
        {
            return (true, [0,1,2,3], Slot.Black)
        } else if theBoard[1][col] == Board.Slot.Black && theBoard[2][col] == Board.Slot.Black
            && theBoard[3][col] == Board.Slot.Black && theBoard[4][col] == Board.Slot.Black
        {
            return (true, [1,2,3,4], Slot.Black)
        }
        else if theBoard[2][col] == Board.Slot.Black && theBoard[3][col] == Board.Slot.Black
            && theBoard[4][col] == Board.Slot.Black && theBoard[5][col] == Board.Slot.Black
        {
            return (true, [2,3,4,5], Slot.Black)
        }
       
        
        // copy paste for red
        if theBoard[0][col] == Board.Slot.Red && theBoard[1][col] == Board.Slot.Red
            && theBoard[2][col] == Board.Slot.Red && theBoard[3][col] == Board.Slot.Red
        {
            return (true, [0,1,2,3], Slot.Red)
        } else if theBoard[1][col] == Board.Slot.Red && theBoard[2][col] == Board.Slot.Red
            && theBoard[3][col] == Board.Slot.Red && theBoard[4][col] == Board.Slot.Red
        {
            return (true, [1,2,3,4], Slot.Red)
        }
        else if theBoard[2][col] == Board.Slot.Red && theBoard[3][col] == Board.Slot.Red
            && theBoard[4][col] == Board.Slot.Red && theBoard[5][col] == Board.Slot.Red
        {
            return (true, [2,3,4,5], Slot.Red)
        }
    
        return (false, [], Slot.None)
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
