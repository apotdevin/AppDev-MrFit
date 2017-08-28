//
//  CustomInterfaceController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/25/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import WatchKit
import Foundation


class CustomInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var exerciseTimeLabel: WKInterfaceLabel!
    @IBOutlet weak var exerciseTimeSlider: WKInterfaceSlider!
    
    @IBOutlet weak var restTimeLabel: WKInterfaceLabel!
    @IBOutlet weak var restTimeSlider: WKInterfaceSlider!
    
    @IBOutlet weak var repetitionsLabel: WKInterfaceLabel!
    @IBOutlet weak var repetitionsSlider: WKInterfaceSlider!
    
    @IBOutlet weak var startButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        self.exerciseTimeLabel.setText("Exercise Time: \(WatchManager.sharedInstance.exerciseTime*10)sec")
        self.exerciseTimeSlider.setValue(Float(WatchManager.sharedInstance.exerciseTime))
        
        self.restTimeLabel.setText("Rest Time: \(WatchManager.sharedInstance.restTime*5)sec")
        self.restTimeSlider.setValue(Float(WatchManager.sharedInstance.restTime))
        
        self.repetitionsLabel.setText("Repetitions: \(WatchManager.sharedInstance.repetitions)")
        self.repetitionsSlider.setValue(Float(WatchManager.sharedInstance.repetitions))
        
        println("llego a custom IController")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func exerciseTimeSliderChanged(_ value: Float)
    {
        WatchManager.sharedInstance.exerciseTime = Int(value)
        self.exerciseTimeLabel.setText("Exercise Time: \(WatchManager.sharedInstance.exerciseTime*10)sec")
    }
    
    @IBAction func restTimeSliderChanged(_ value: Float)
    {
        WatchManager.sharedInstance.restTime = Int(value)
        self.restTimeLabel.setText("Rest Time: \(WatchManager.sharedInstance.restTime*5)sec")
    }
    
    @IBAction func repetitionsSliderChanged(_ value: Float)
    {
        WatchManager.sharedInstance.repetitions = Int(value)
        self.repetitionsLabel.setText("Repetitions: \(WatchManager.sharedInstance.repetitions)")
    }

}
