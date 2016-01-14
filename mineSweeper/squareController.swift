//
//  squareController.swift
//  mineSweeper
//
//  Created by Zachary Stallings on 1/12/16.
//  Copyright (c) 2016 Stallings.inc. All rights reserved.
//

import Foundation


class squareController {
    
    var squareArr: [square] = []
    var parentWidth: Double = 0
    var parentHeight: Double = 0
    var padding: Double = 40
    var squarePadding: Double = 2
    var numberOfSquaresEasy: Int = 6
    var numberOfSquaresMed: Int = 8
    var numberOfSquaresHard: Int = 10
    var numberOfSquares: Int?
    var startXPos: Double = 40
    var startYPos: Double = 40
    var gameLost: Bool = false
    var gameWon: Bool = false
    var difficulty: String?
    
    typealias squareSC = square
    
    init(difficulty: String) {
        self.setDifficulty(difficulty)
    }
    
    func setDifficulty(difficulty: String) {
        self.difficulty = difficulty
        self.numberOfSquares = self.setNumberOfSquares(difficulty)
    }
    
    func setNumberOfSquares(difficulty: String) -> Int {
        var num: Int?
        switch difficulty.lowercaseString {
            case "medium":
                num = self.numberOfSquaresMed
            case "hard":
                num = self.numberOfSquaresHard
            case "easy":
                num = self.numberOfSquaresEasy
            default:
                num = self.numberOfSquaresEasy
        }
        
        return num!
    }
    
    func getNumberOfSquares() -> Int {
        return self.numberOfSquares!
    }
    
    func initParentSize(width: Double, height: Double) {
        self.parentWidth = width
        self.parentHeight = height
    }
    
    func add(square: squareSC) {
        self.squareArr.append(square)
    }
    
    func addSquare(square: squareSC) {
        self.add(square)
        self.randAddBomb(square)
    }
    
    func find(tag: Int) -> square {
        var sqr = self.squareArr.first
        var i = 0;
        for sq in squareArr {
            if (sq.tagNo == tag) {
                sqr = sq
                return sqr!
            }
            
            ++i
        }
        
        return sqr!
    }
    
    func unvisit() {
        for sq in squareArr {
            sq.unVisit()
        }
    }
    
    func revealBombs() {
        for sq in squareArr {
            if sq.hasBomb {
                sq.hit()
                sq.animate()
                sq.exposion()
            }
            
            sq.disableButton()
        }
    }
    
    func squarePress(tag: Int) {
        var sq = find(tag)
        self.unvisit()
        self.afterPressed(sq)
    }
    
    func squareHeld(tag: Int) {
        var sq = find(tag)
        sq.flag()
    }
    
    func isWon() -> Bool {
        var won: Bool = true
        for sq in squareArr {
            if sq.hasBomb && !sq.hidden {
                won = false
            }
            
            if !sq.hasBomb && sq.hidden {
                won = false
            }
        }
        
        print("is won \(won)")
        
        self.gameWon = won
        
        return won
    }
    
    func afterPressed(sq: square) {
        var neighbors = getNeighbors(Double(sq.tagNo - 1))
        var sum = neighborSum(neighbors)
        
        var action: String = sq.pressed(sum)
        sq.visit();
        self.isWon()
        if action == "blank" {
            revealNeighbors(neighbors)
        }
        
        if action == "hit" {
            revealBombs()
            self.gameLost = true
        }
    }
    
    func revealNeighbors(neighbors: Array<square>) {
        for neighbor in neighbors {
            if !neighbor.visited && !neighbor.hasBomb {
                afterPressed(neighbor)
            }
        }
    }
    
    func neighborSum(neighbors: Array<square>) -> Int {
        var sum: Int = 0
        for neighbor in neighbors {
            sum += neighbor.bombCount()
        }
        
        return sum
    }
    
    func getNeighbors(i: Double) -> Array<square> {
        var neighbors: [square] = []
        var neighborIdx: Int = 0
        
        for index in getNeighborPoss(i) {
            
            if !isNeighborOutOfRange(index.first!, adjuster: index.last!) {
                neighborIdx = Int(index.first! + index.last!)
                neighbors.append(squareArr[neighborIdx])
            }
        }
        
        return neighbors
    }
    
    
    //TODO: find a better way tos get neighbors without all these arrays
    func getNeighborPoss(i: Double) -> Array<Array<Double>> {
        var num = Double(self.getNumberOfSquares())
        var neighbors: Array<Array<Double>> = [
            [i - num, -1], [i - num, 0], [i - num, 1],
            [i,       -1],               [i,       1],
            [i + num, -1], [i + num, 0], [i + num, 1]
        ]
        
        return neighbors
    }
    
    //TODO: add row ranges from squares so rowPos if == 5 can be variable for harder games
    func isNeighborOutOfRange(pos: Double, adjuster: Double) -> Bool {
        var rowPos = pos % getNumberSqrPerRow()
        var isOutOfRow = (rowPos == getNumberSqrPerRow() - 1 && adjuster == 1.0) || (rowPos == 0 && adjuster == -1.0)
        var isOutOfArr = ( pos < 0.0 || pos > Double(squareArr.count - 1))
        return isOutOfArr || isOutOfRow
    }
    
    func populate(funcParam: (xPos: Double, yPos: Double, width: Double, height: Double) -> ()) {
        var sqWidth: Double = getSquareWidth(Double(self.getNumberOfSquares()))
        var sqHeight: Double = sqWidth
        var x: Double = 0
        var y: Double = 0
        var i: Double = 0
        for row in 1...Int(getTotalNumSquares()) {
            funcParam(xPos: Double(getXPos(x)), yPos: getYPos(y), width: sqWidth, height: sqHeight)
            ++i
            
            x = ++x % Double(self.getNumberOfSquares())

            if x == 0 {
                ++y
            }
        }
    }
    
    func getYPos(num: Double) -> Double {
        return num == 0 ? self.startYPos : self.startYPos + (num * (self.squarePadding + getSquareWidth(Double(self.getNumberOfSquares()))))
    }
    
    func getXPos(num: Double) -> Double {
        return num == 0 ? self.startXPos : self.startXPos + (num * (self.squarePadding + getSquareWidth(Double(self.getNumberOfSquares()))))
    }
    
    func getTotalNumSquares() -> Double {
        return round(numberOfRows()) * Double(self.getNumberOfSquares())
    }
    
    func numberOfRows() -> Double {
        var width = getSquareWidth(Double(self.getNumberOfSquares()));
        var useableHeight = getUsableHeight() - width
        return useableHeight / width
    }
    
    func getUsableHeight() -> Double {
        return self.parentHeight - (self.padding * 2)
    }
    
    
    // TODO: make more efficent. dont calculate each time
    func getUsableWidth() -> Double {
        return self.parentWidth - (self.padding * 2)
    }
    
    func getSquareWidth(numberOfSquares: Double) -> Double {
        return (getUsableWidth() - getSquarePadding(numberOfSquares)) / numberOfSquares
    }
    
    func getSquarePadding(numberOfSquares: Double) -> Double {
        return numberOfSquares * self.squarePadding - 1
    }
    
    func randAddBomb(square: squareSC) {
        var total = getTotalNumSquares()
        var addBomb = Double(randomNumber(UInt32(total))) <= (total * 0.13333)
        if addBomb {
            square.addBomb()
        }
    }
    
    func randomNumber(num: UInt32) -> Int {
        return Int(arc4random_uniform(num) + 1)
    }
    
    func getNumberSqrPerRow() -> Double {
        return Double(self.getNumberOfSquares())
    }
    
    func disableSquares() {
        for sq in squareArr {
            sq.disableButton()
        }
    }
    
    func enableSquares() {
        for sq in squareArr {
            sq.enableButton()
        }
    }
    
    
    func clearSquares() {
        for sq in squareArr {
            sq.clearView()
        }
        
        squareArr = []
    }
    
    func reset() {
        self.clearSquares()
        self.gameLost = false
    }
    
}