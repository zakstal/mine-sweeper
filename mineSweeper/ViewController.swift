//
//  ViewController.swift
//  mineSweeper
//
//  Created by Zachary Stallings on 1/11/16.
//  Copyright (c) 2016 Stallings.inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tagNo = 1
    var squareCont: squareController?
    var xpos = 50
    var menu: menuScreen?
    typealias sqareVC = square
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSquareController()
        self.populate()
        self.squareCont!.disableSquares()
        self.showMenu(0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSquareController() {
        self.squareCont = squareController(difficulty: "hard")
        self.squareCont!.initParentSize(Double(view.frame.width), height: Double(view.frame.height))
    }
    
    func populate() {
        squareCont!.populate(mksq)
    }
    
    func mksq(xPos: Double, yPos: Double, width: Double, height: Double) {
        makeSquare(xPos, yPos: yPos, width: width ,height: height)
    }
    
    func makeSquare(xPos: Double, yPos: Double, width: Double, height: Double) {
        var sqr = square(xPos: xPos, yPos: yPos, width: width, height: height, tagNo: tagNo)
        squareCont!.addSquare(sqr)
        sqr.button!.addTarget(self, action: "pressedSquare:", forControlEvents: .TouchUpInside)
        sqr.button!.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: "handleLongPress:"))
        
        self.view.addSubview(sqr.view)
        self.advanceTagNo()
    }
    
    func showMenu(delay: Int) {
        self.menu = menuScreen(xPos: 65, yPos: -600, width: 247, height: 458, tagNo: 1)
        self.menu!.setActiveDifficultyButton(self.squareCont!.difficulty!)
        view.addSubview(self.menu!.view)
        self.menu!.startButton!.addTarget(self, action: "startGame:", forControlEvents: .TouchUpInside)
        self.menu!.easyButton!.addTarget(self, action: "chooseDifficulty:", forControlEvents: .TouchUpInside)
        self.menu!.medButton!.addTarget(self, action: "chooseDifficulty:", forControlEvents: .TouchUpInside)
        self.menu!.hardButton!.addTarget(self, action: "chooseDifficulty:", forControlEvents: .TouchUpInside)
        self.menu!.showScreen(Double(delay))
    }
    
    func startGame(sender: UIButton!) {
        self.menu?.hideScreen()
        self.squareCont!.reset()
        self.resetTagNo()
        self.populate()
    }
    
    func handleLongPress(gesture: UILongPressGestureRecognizer) {
        self.squareCont!.squareHeld(gesture.view!.tag)
    }
    
    func pressedSquare(sender: UIButton!) {
        self.squareCont!.squarePress(sender.tag)
        self.gameLost()
        self.gameWon()
    }
    
    func gameLost() {
        if self.squareCont!.gameLost {
            self.showMenu(2)
            squareCont!.disableSquares()
            self.menu!.changeInfoText("Sorry, you lost")
        }
    }
    
    func gameWon() {
        if self.squareCont!.gameWon {
            self.showMenu(1)
            squareCont!.disableSquares()
            self.menu!.changeInfoText("Yay! You won!")
        }
    }
    
    func chooseDifficulty(sender: UIButton!) {
        sender.highlighted = true
        self.squareCont!.setDifficulty(sender.currentTitle!)
        self.menu!.setActiveDifficultyButton(sender.currentTitle!)
    }
    
    func advanceTagNo() {
        ++self.tagNo
    }
    
    func resetTagNo() {
        self.tagNo = 1
    }
}

