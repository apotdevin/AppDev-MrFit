//
//  CustomStartInterfaceController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/26/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import WatchKit
import Foundation


class CustomStartInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var repetitionsLabel: WKInterfaceLabel!
    @IBOutlet weak var timerLabel: WKInterfaceLabel!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    
    var timer = Timer()
    var countDownNumber = 0
    var phase = "getReady"
    
    let customExerciseTime = WatchManager.sharedInstance.exerciseTime
    let customRestTime = WatchManager.sharedInstance.restTime
    let customRepetitions = WatchManager.sharedInstance.repetitions
    
    var currentRepetition = 1
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        self.getReady()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CustomStartInterfaceController.seconds), userInfo: nil, repeats: true)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        
        timer.invalidate()
    }
    
    func seconds()
    {
        if countDownNumber > 0
        {
            countDownNumber -= 1
            
            self.setTimerLabel()
        }
        if countDownNumber == 0
        {
            if phase == "getReady"
            {
                if customRepetitions == 1
                {
                    phase = "lastExercise"
                    startExercise()
                }
                else
                {
                    phase = "exercise"
                    startExercise()
                }
            }
            else if phase == "exercise"
            {
                phase = "wait"
                startWait()
            }
            else if phase == "wait"
            {
                currentRepetition += 1
                self.repetitionsLabel.setText("Repetitions: \(currentRepetition)-\(customRepetitions)")
                
                if currentRepetition >= customRepetitions-1
                {
                    phase = "lastExercise"
                    startExercise()
                }
                else
                {
                    phase = "exercise"
                    startExercise()
                }
            }
            else if phase == "lastExercise"
            {
                self.timer.invalidate()
                self.timerLabel.setText("DONE!")
                self.titleLabel.setText("")
                self.repetitionsLabel.setText("")
            }
        }
    }
    
    func getReady()
    {
        self.repetitionsLabel.setText("Repetitions: 1-\(customRepetitions)")
        countDownNumber+=5
        self.setTimerLabel()
        self.titleLabel.setText("Get Ready!")
    }
    
    func startExercise()
    {
        countDownNumber += (customExerciseTime*10)
        
        self.setTimerLabel()
        self.titleLabel.setText("Let's do it!")
    }
    
    func startWait()
    {
        countDownNumber += (customRestTime*5)
        self.setTimerLabel()
        self.titleLabel.setText("Rest!")
    }
    
    func setTimerLabel()
    {
        if countDownNumber > 9
        {
            self.timerLabel.setText("\(countDownNumber)")
        }
        else
        {
            self.timerLabel.setText("0\(countDownNumber)")
        }
    }
}
