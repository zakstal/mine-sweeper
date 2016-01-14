//
//  menuScreen.swift
//  mineSweeper
//
//  Created by Zachary Stallings on 1/13/16.
//  Copyright (c) 2016 Stallings.inc. All rights reserved.
//

import Foundation
import UIKit

class menuScreen: pageElement {
    
    var startButton: UIButton?
    var easyButton: UIButton?
    var medButton: UIButton?
    var hardButton: UIButton?
    var textInfo: UITextField?
    
    
    override init(xPos: Double, yPos: Double, width: Double, height: Double, tagNo: Int) {
        super.init(xPos: xPos, yPos: yPos, width: width, height: height, tagNo: tagNo)
        self.setBackgroundColor()
        self.setBorder()
        self.addStartButton()
        self.addEasyButton()
        self.addMedButton()
        self.addHardButton()
        self.addTitle()
        self.addTextInfo("You can do it!")
        self.view.layer.cornerRadius = 10;
    }
    
    func setBackgroundColor() {
        self.view.backgroundColor = UIColor(hue: 297/360, saturation: 26/100, brightness: 87/100, alpha: 1.0)
    }
    
    func setBorder() {
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor(red: 0.549, green: 0, blue: 0.3373, alpha: 1.0).CGColor
    }
    
    func addStartButton() {
        var button = makeButton()
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitle("START", forState: .Normal)
        button.frame = CGRectMake(25, 350, CGFloat(200), CGFloat(80))
        button.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 25)
        button.backgroundColor = UIColor(red: 0.5765, green: 0, blue: 0.8667, alpha: 1.0)
        button.layer.cornerRadius = 10;
        self.startButton = button
    }
    
    func addEasyButton() {
        var button = makeChallengeButton("Easy")
        button.frame = CGRectMake(50, 210, CGFloat(150), CGFloat(30))
        self.easyButton = button
    }
    
    func addMedButton() {
        var button = makeChallengeButton("Medium")
        button.frame = CGRectMake(50, 250, CGFloat(150), CGFloat(30))
        self.medButton = button
    }
    
    func addHardButton() {
        var button = makeChallengeButton("Hard")
        button.frame = CGRectMake(50, 290, CGFloat(150), CGFloat(30))
        self.hardButton = button
    }
    
    func makeChallengeButton(difficulty: String) -> UIButton {
        var button = makeButton()
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.setTitle(difficulty, forState: .Normal)
        button.titleLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 15)
        button.backgroundColor = UIColor(red: 0.5765, green: 0, blue: 0.8667, alpha: 1.0)
        button.layer.cornerRadius = 5;
        
        return button
        
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
        self.view.addSubview(button)
        
        return button
    }
    
    func addTitle() {
        let text = UITextField(frame: CGRectMake(47, 30, 300, 40))
        text.text = "Mine Sweeper!"
        text.font = UIFont(name: "HelveticaNeue-Thin", size: 25)
        text.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        text.textColor = UIColor(red: 0.1529, green: 0, blue: 0.3569, alpha: 1.0)
        self.view.addSubview(text)
    }
    
    
    func addTextInfo(textInfo: String) {
        let text = UITextField(frame: CGRectMake(60, 110, 300, 40))
        text.text = textInfo
        text.font = UIFont(name: "HelveticaNeue-Thin", size: 20)
        text.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        text.textColor = UIColor(red: 0.1529, green: 0, blue: 0.3569, alpha: 1.0)
        self.textInfo = text
        self.view.addSubview(self.textInfo!)
    }
    
    func changeInfoText(text: String) {
        self.textInfo!.text = text
    }
    
    func showScreen(delay: Double) {
        self.view.layer.zPosition = 11
        UIView.animateWithDuration(0.4, delay: delay, options: nil, animations: {
            self.view.frame = self.makeFrame(67, y: 150, width: 247, height: 458)
         }, completion: nil)
        
        UIView.animateWithDuration(0.3, delay: delay + 0.4, options: nil, animations: {
            self.view.frame = self.makeFrame(67, y: 102, width: 247, height: 458)
         }, completion: nil)
    }
    
    func hideScreen() {
        UIView.animateWithDuration(0.5, animations: {
            self.view.frame = self.makeFrame(67, y: 50, width: 247, height: 458)
        })
        
        UIView.animateWithDuration(0.5, delay: 0.5, options: nil, animations: {
            self.view.frame = self.makeFrame(67, y: 1000, width: 247, height: 458)
        }, completion: nil)
    }
}