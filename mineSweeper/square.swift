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
    var flagImage: UIImageView?
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
        if (self.hasBomb) {
            var image: UIImage = UIImage(named: "explosion.png")!
            var bgImage = UIImageView(image: image)
            bgImage.frame = CGRectMake(5, 5, CGFloat(self.width - 10) , CGFloat(self.height - 10))
            self.view.addSubview(bgImage)
            self.text("")
        }
        
        self.button!.setTitleColor(UIColor.greenColor(), forState: .Normal)
    }
    
    
    // Returns true if
    func pressed(numNeighborBombs: Int) -> String {
        self.hit()
        if self.hasBomb {
            return "hit"
        } else if numNeighborBombs == 0 {
            self.text("")
            return "blank"
        } else {
            self.text(String(numNeighborBombs))
            self.setTextNumberColor(numNeighborBombs)
            return "not blank"
        }
    }
    
    func text(text: String) {
        self.button!.setTitle(text, forState: .Normal)
    }
    
    func setTextNumberColor(num: Int) {
        switch num {
        case 1:
            self.button!.setTitleColor(UIColor.greenColor(), forState: .Normal)
        case 2:
            self.button!.setTitleColor(UIColor(red: 0.1882, green: 0, blue: 0.8196, alpha: 1.0), forState: .Normal)
        case 3:
            self.button!.setTitleColor(UIColor(red: 0, green: 0.5294, blue: 0.8392, alpha: 1.0), forState: .Normal)
        case 4:
            self.button!.setTitleColor(UIColor(red: 0.7882, green: 0.2353, blue: 0, alpha: 1.0), forState: .Normal)
        case 5:
            self.button!.setTitleColor(UIColor(red: 0.8588, green: 0.1137, blue: 0, alpha: 1.0), forState: .Normal)
        case 6:
            self.button!.setTitleColor(UIColor(red: 0.9294, green: 0.0275, blue: 0, alpha: 1.0), forState: .Normal)
        case 7:
            self.button!.setTitleColor(UIColor(red: 1, green: 0, blue: 0, alpha: 1.0), forState: .Normal)
        default:
            self.button!.setTitleColor(UIColor.greenColor(), forState: .Normal)
        }
        
        
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
            var image: UIImage = UIImage(named: "flag.png")!
            self.flagImage = UIImageView(image: image)
            self.flagImage!.frame = CGRectMake(5, 5, CGFloat(self.width - 10) , CGFloat(self.height - 10))
            self.view.addSubview(self.flagImage!)
        } else {
            self.flagImage?.removeFromSuperview()
        }
        
        

    }
    
    func flagAnimation() {
        var zIndex = self.view.layer.zPosition
        
        UIView.animateWithDuration(0.3, animations: {
            // animating `transform` allows us to change 2D geometry of the object
            // like `scale`, `rotation` or `translate`
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