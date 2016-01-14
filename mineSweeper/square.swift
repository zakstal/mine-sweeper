//
//  square.swift
//  mineSweeper
//
//  Created by Zachary Stallings on 1/12/16.
//  Copyright (c) 2016 Stallings.inc. All rights reserved.
//

import Foundation
import UIKit

class square: pageElement {
    var test: String = "hello"
    var button: UIButton?
    var hidden = true
    var hasBomb = false
    var visited = false
    var flagged = false
    
    override init(xPos: Double, yPos: Double, width: Double, height: Double, tagNo: Int) {
        super.init(xPos: xPos, yPos: yPos, width: width, height: height, tagNo: tagNo)
        makeSquare()
        self.button = styeledButton()
        self.view.addSubview(button!)
    }
    
    func styeledButton() -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        button.frame = CGRectMake(0, 0, CGFloat(self.width), CGFloat(self.height))
        button.tag = self.tagNo
        
        return button
    }
    
    func hit() {
        self.show()
        UIView.animateWithDuration(0.1, animations: {
            self.colorHit()
            self.hitText()
        })
    }
    
    func colorHit() {
        self.view.backgroundColor = UIColor(hue: 339/360, saturation: 100/100, brightness: 91/100, alpha: 1.0)
    }
    
    func hitText() {
        text(self.hasBomb ? "B" : "O")
        self.button!.setTitleColor(UIColor.greenColor(), forState: .Normal)
    }
    
    
    // Returns true if
    func pressed(numNeighborBombs: Int) -> String {
        self.hit()
        if self.hasBomb {
            return "hit"
        } else if numNeighborBombs == 0 {
            text("")
            return "blank"
        } else {
            text(String(numNeighborBombs))
            return "not blank"
        }
    }
    
    func text(text: String) {
        self.button!.setTitle(text, forState: .Normal)
    }
    
    func addBomb() {
        self.hasBomb = true
    }
    
    func bombCount() -> Int {
        return self.hasBomb ? 1 : 0
    }
    
    func visit() {
        self.visited = true
    }
    
    func unVisit() {
        self.visited = false
    }
    
    func disableButton() {
        self.button!.enabled = false
    }
    
    func enableButton() {
        self.button!.enabled = true
    }
    
    func exposion () {
        UIView.animateWithDuration(0.3, delay: 0.3, options: nil, animations: {
           self.view.backgroundColor =  UIColor(red: 0.9294, green: 0.5882, blue: 0, alpha: 1.0)
        }, completion: { (finished: Bool) -> Void in
               self.toRed()
        })
    }
    
    func toRed() {
        UIView.animateWithDuration(1, delay: 0, options: nil, animations: {
            self.colorHit()
        }, completion: {(finished: Bool) -> Void in
            self.exposion()
        })
    }
    
    func animate() {
        var zIndex = self.view.layer.zPosition
        
        UIView.animateWithDuration(0.3, animations: {
            // animating `transform` allows us to change 2D geometry of the object
            // like `scale`, `rotation` or `translate`
            self.view.backgroundColor =  UIColor.yellowColor()
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 4, 4)
            self.view.layer.zPosition = 10
        })
        
        UIView.animateWithDuration(0.3, animations: {
            // animating `transform` allows us to change 2D geometry of the object
            // like `scale`, `rotation` or `translate`
            self.view.backgroundColor =  UIColor(hue: 339/360, saturation: 100/100, brightness: 91/100, alpha: 1.0)
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
            self.view.layer.zPosition = zIndex
        })
    }
    
    func flag() {
        self.flagged = self.flagged ? false : true
        if self.flagged {
            self.flagAnimation()
        } else {
            self.setDefault()
        }

    }
    
    func flagAnimation() {
        var zIndex = self.view.layer.zPosition
        
        UIView.animateWithDuration(0.3, animations: {
            // animating `transform` allows us to change 2D geometry of the object
            // like `scale`, `rotation` or `translate`
            self.view.backgroundColor =  UIColor(red: 0.2353, green: 0, blue: 0.6784, alpha: 1.0)
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 4, 4)
            self.view.layer.zPosition = 10
        })
        
        UIView.animateWithDuration(0.3, animations: {
            // animating `transform` allows us to change 2D geometry of the object
            // like `scale`, `rotation` or `translate`
            self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
            self.view.layer.zPosition = zIndex
        })

    }
    
    func setDefault() {
        self.view.backgroundColor =  UIColor(red: 0.9294, green: 0.5882, blue: 0, alpha: 1.0)

    }
    
    func clearView() {
        self.view.removeFromSuperview()
    }
    
    func hide() {
        self.hidden = true
    }
    
    func show() {
        self.hidden = false
    }
}