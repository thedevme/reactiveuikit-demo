//
//  FirstViewController.swift
//  ReactiveKitDemo
//
//  Created by Craig Clayton on 7/19/16.
//  Copyright © 2016 Cocoa Academy. All rights reserved.
//

import UIKit
import ReactiveKit
import ReactiveUIKit

class BasicExampleController: UIViewController {
    
    var homeScoreValue = 0
    var awayScoreValue = 0
    
    var homeScore = Property<String>("0")
    var awayScore = Property<String>("0")
    
    @IBOutlet var lblAway: UILabel!
    @IBOutlet var lblHome: UILabel!
    @IBOutlet var lblDisplay: UILabel!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var switchReactive: UISwitch!
    @IBOutlet var btnReset: UIButton!
    @IBOutlet var barBtnCamera: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTimer()
        addObservers()
    }

    func addObservers() {
        switchReactive.rOn.skip(1).observeNext { [weak self] value in
            guard let weakSelf = self else { return }
            
            weakSelf.lblDisplay.rText.value = "\(value)"
            
        }.disposeIn(rBag)
        
        segmentControl.rSelectedSegmentIndex.skip(1).observeNext { [weak self] value in
            guard let weakSelf = self else { return }
            
            if value == 0 { weakSelf.lblDisplay.rText.value = "Players Segment selected" }
            else { weakSelf.lblDisplay.rText.value = "Coaches Segment selected"  }
            
        }.disposeIn(rBag)
        
        barBtnCamera.rTap.observeNext { [weak self] _ in
            guard let weakSelf = self else { return }
            
            weakSelf.lblDisplay.rText.value = "Camera Tapped"
            
        }.disposeIn(rBag)
        
        btnReset.rTap.observeNext { [weak self] _ in
            guard let weakSelf = self else { return }
            
            weakSelf.homeScoreValue = 0
            weakSelf.awayScoreValue = 0
            weakSelf.awayScore.value = "0"
            weakSelf.homeScore.value = "0"
            
        }.disposeIn(rBag)
    }
    
    func createTimer() {
        let timer = NSTimer(timeInterval: 5, target: self, selector: #selector(BasicExampleController.updateData), userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }

    func updateData() {
        let random = Int(arc4random_uniform(10) + 1)
        let randomTeam = Int(arc4random_uniform(2))

        if randomTeam == 0 {
            awayScoreValue += random
            awayScore.value = "\(awayScoreValue)"
            awayScore.bindTo(lblAway)
        }
        else {
            homeScoreValue += random
            homeScore.value = "\(homeScoreValue)"
            homeScore.bindTo(lblHome)
        }
    }
}
