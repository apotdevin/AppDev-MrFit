//
//  StartInterfaceController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/25/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import WatchKit
import Foundation


class StartInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var setLabel: WKInterfaceLabel!
    @IBOutlet weak var exerciseLabel: WKInterfaceLabel!
    @IBOutlet weak var timerLabel: WKInterfaceLabel!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    
    var countDownNumber = 0
    var currentExercise = 0
    var currentRep = 1
    var phase = "getReady"
    
    var timer = Timer()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        self.getReady()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StartInterfaceController.seconds), userInfo: nil, repeats: true)
        
        println("llego a start IController")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        timer.invalidate()
        
        super.didDeactivate()
    }
    
    func seconds()
    {
        if countDownNumber > 0
        {
            countDownNumber -= 1
            self.setTime()
        }
        if countDownNumber == 0
        {
            if phase == "getReady"
            {
                phase = "exercise"
                startExercise()
            }
            else if phase == "exercise"
            {
                phase = "wait"
                startWait()
            }
            else if phase == "wait"
            {
                currentExercise += 1
                
                if currentExercise == WatchManager.sharedInstance.cualExercise.exercises.count-1
                {
                    phase = "lastExercise"
                    startLastExercise()
                }
                else
                {
                    phase = "exercise"
                    startExercise()
                }
            }
            else if phase == "lastExercise"
            {
                if currentRep >= WatchManager.sharedInstance.cualExercise.currentSets
                {
                    phase = "finished"
                    currentExercise = 0
                    
                    timer.invalidate()
                    self.timerLabel.setText("DONE!")
                    self.setLabel.setText("")
                    self.exerciseLabel.setText("")
                    self.nameLabel.setText("")
                }
                else
                {
                    phase = "repWait"
                    currentExercise = 0
                    currentRep += 1
                    startRepWait()
                }
            }
            else if phase == "repWait"
            {
                phase = "exercise"
                startExercise()
            }
        }
    }
    
    
    func getReady()
    {
        self.nameLabel.setText("Get ready!")
        self.setLabel.setText("Set: \(currentRep)-\(WatchManager.sharedInstance.cualExercise.currentSets)")
        self.exerciseLabel.setText("Exercise: \(currentExercise)-\(WatchManager.sharedInstance.cualExercise.exercises.count)")
        countDownNumber+=7
        self.setTime()
    }
    
    func startExercise()
    {
        self.nameLabel.setText("\(WatchManager.sharedInstance.cualExercise.exercises[currentExercise])")
        self.setLabel.setText("Set: \(currentRep)-\(WatchManager.sharedInstance.cualExercise.currentSets)")
        self.exerciseLabel.setText("Exercise: \(currentExercise+1)-\(WatchManager.sharedInstance.cualExercise.exercises.count)")
        countDownNumber += WatchManager.sharedInstance.cualExercise.exerciseTimes[currentExercise]
        self.setTime()
    }
    
    func startLastExercise()
    {
        self.nameLabel.setText("\(WatchManager.sharedInstance.cualExercise.exercises[currentExercise])")
        self.setLabel.setText("Set: \(currentRep)-\(WatchManager.sharedInstance.cualExercise.currentSets)")
        self.exerciseLabel.setText("Exercise: \(currentExercise+1)-\(WatchManager.sharedInstance.cualExercise.exercises.count)")
        countDownNumber += WatchManager.sharedInstance.cualExercise.exerciseTimes[currentExercise]
        self.setTime()
    }
    
    func startWait()
    {
        self.nameLabel.setText("REST!")
        countDownNumber += (WatchManager.sharedInstance.cualExercise.waitTimes[currentExercise])
        self.setTime()
    }
    
    func startRepWait()
    {
        self.nameLabel.setText("Rest for next rep!")
        self.setLabel.setText("Set: \(currentRep)-\(WatchManager.sharedInstance.cualExercise.currentSets)")
        self.exerciseLabel.setText("Exercise: 0-\(WatchManager.sharedInstance.cualExercise.exercises.count)")
        countDownNumber += 30
        self.setTime()
    }
    
    func setTime()
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
