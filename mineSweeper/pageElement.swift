//
//  pageElement.swift
//  mineSweeper
//
//  Created by Zachary Stallings on 1/13/16.
//  Copyright (c) 2016 Stallings.inc. All rights reserved.
//

import Foundation
import UIKit

class pageElement {
    var frame: CGRect = CGRect()
    var view = UIView()
    var xPos = Double()
    var yPos = Double()
    var width = Double()
    var height = Double()
    var tagNo: Int = 0
 
    
    init(xPos: Double, yPos: Double, width: Double, height: Double, tagNo: Int) {
        self.xPos = xPos
        self.yPos = yPos
        self.width = width
        self.height = height
        self.tagNo = tagNo
        self.makeSquare()
    }
    
    func makeSquare() {
        self.frame = makeFrame(CGFloat(self.xPos), y: CGFloat(self.yPos), width: CGFloat(self.width), height: CGFloat(self.height))
        self.view = makeView(self.frame)
        self.view.backgroundColor = UIColor(hue: 288/360, saturation: 100/100, brightness: 72/100, alpha: 1.0)
        
    }
    
    func makeFrame(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func makeView(frame: CGRect) -> UIView {
        return UIView(frame: frame)
    }
}