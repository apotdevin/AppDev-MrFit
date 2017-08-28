//
//  WatchManager.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/25/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import Foundation
import WatchKit

class WatchManager {
    
    private static var __once: () = {
            Static.instance = WatchManager()
        }()
    
    class var sharedInstance: WatchManager {
        struct Static {
            static var instance: WatchManager?
            static var token: Int = 0
        }
        _ = WatchManager.__once
        return Static.instance!
    }
    
    var cualExercise = WatchRoutine()
    var menuItems = ["7 Minute Workout","Perfect Six Pack","The Dark Knight","In a Hurry Abs","Need Legs?","The Soldier","The Samurai","Full Fit","Custom Timer"]
    
    var exerciseTime = 1
    var restTime = 1
    var repetitions = 1
    
    var armInfo = 0
    
    func startWatchApp()
    {
        let sharedDefaults = UserDefaults(suiteName: "group.com.MrFit.shared")
        let bought = sharedDefaults?.integer(forKey: "ArmInfo")
        armInfo = bought!
        
        if bought != 5201
        {
            menuItems = ["7 Minute Workout","Perfect Six Pack","The Dark Knight"]
        }
        
        self.startWorkouts()
        self.startColors()
    }
    
    //---------------------------------------------------------------------------------------------------------------------------
    //WORKOUT
    
    let original = WatchRoutine()
    let steelAbs = WatchRoutine()
    let twoMinAbs = WatchRoutine()
    let batman = WatchRoutine()
    let legDay = WatchRoutine()
    let navySeal = WatchRoutine()
    let ninja = WatchRoutine()
    let aquaman = WatchRoutine()
    
    func startWorkouts ()
    {
        original.name = "7 Minute Workout"
        original.exercises = ["Jumping Jacks","Wall Sits","Push-ups","Crunches","Step up onto Chair","Squats","Triceps dip on Chair","Elbow Plank","High knees running in place","Lunges","Push-up and rotation","Side Plank"]
        original.exerciseTimes = [30,30,30,30,30,30,30,30,30,30,30,30]
        original.waitTimes = [10,10,10,10,10,10,10,10,10,10,10,0]
        original.sets = [1,2,3]
        original.setWaitTime = 60
        original.setDescription = ["Beginner","Intermediate","Expert"]
        original.currentSets = 1
        
        steelAbs.name = "Perfect Six Pack"
        steelAbs.exercises = ["Long arm crunches","Air bike crunches","Reverse crunches","Crunches","Cross crunches","Knee crunches"]
        steelAbs.exerciseTimes = [20,30,20,30,20,20]
        steelAbs.waitTimes = [5,5,5,5,5,0]
        steelAbs.sets = [3,5,7]
        steelAbs.setWaitTime = 60
        steelAbs.setDescription = ["Beginner","Intermediate","Expert"]
        steelAbs.currentSets = 3
        
        twoMinAbs.name = "In a Hurry Abs"
        twoMinAbs.exercises = ["Knee crunches","Flutter kicks","Scissors","Hundreds","Reverse crunches","Sitting Twists"]
        twoMinAbs.exerciseTimes = [20,20,20,20,20,20]
        //twoMinAbs.exerciseTimes = [5,5,5,5,5,5]
        twoMinAbs.waitTimes = [5,5,5,5,5,5]
        twoMinAbs.sets = [1,2,3,4,5]
        twoMinAbs.setWaitTime = 60
        twoMinAbs.setDescription = ["Basic","Starter","Intermediate","Expert","Let's do it"]
        twoMinAbs.currentSets = 1
        
        batman.name = "The Dark Night"
        batman.exercises = ["Shoulder Taps","Climbers","Sit-up Punches","Squats","Sitting Twists","Punches","Jumping Lunges","Push-ups","Leg Raises"]
        batman.exerciseTimes = [30,30,20,30,10,50,20,20,20]
        batman.waitTimes = [5,5,5,5,5,5,5,5,5]
        batman.sets = [3,5,7,10]
        batman.setWaitTime = 60
        batman.setDescription = ["Beginner","Intermediate","Expert","Master"]
        batman.currentSets = 5
        
        legDay.name = "Need legs?"
        legDay.exercises = ["Lunges","Climbers","Squats","Side Leg Raises","Split Squats"]
        legDay.exerciseTimes = [24,30,30,30,20]
        legDay.waitTimes = [5,5,5,5,5]
        legDay.sets = [3,5,7]
        legDay.setWaitTime = 60
        legDay.setDescription = ["Beginner","Intermediate","Expert"]
        legDay.currentSets = 3
        
        navySeal.name = "The Soldier"
        navySeal.exercises = ["Push-ups","High knees running in place","Squats","High knees running in place","Pull-ups","High knees running in place"]
        navySeal.exerciseTimes = [30,40,30,40,30,40]
        navySeal.waitTimes = [5,5,5,5,5,5]
        navySeal.sets = [3,5,7]
        navySeal.setWaitTime = 60
        navySeal.setDescription = ["Beginner","Intermediate","Expert"]
        navySeal.currentSets = 3
        
        ninja.name = "The Samurai"
        ninja.exercises = ["Squats","Chest Expansion","Wall Sits","Side Leg Raises","Turning Kicks","Punches","Push-ups","Elbow Plank","Plank Arm Raises"]
        ninja.exerciseTimes = [30,30,20,50,30,30,20,20,30]
        ninja.waitTimes = [5,5,5,5,5,5,5,5,5]
        ninja.sets = [3,5,7]
        ninja.setWaitTime = 60
        ninja.setDescription = ["Beginner","Intermediate","Expert"]
        ninja.currentSets = 3
        
        aquaman.name = "Full Fit"
        aquaman.exercises = ["Squats","Shoulder Taps","Elbow Plank","Leg Raises","Windshield Wipers","Get-ups","Diver Push-ups"]
        aquaman.exerciseTimes = [20,20,30,20,20,20,30]
        aquaman.waitTimes = [5,5,5,5,5,5,5]
        aquaman.sets = [3,5,7]
        aquaman.setWaitTime = 60
        aquaman.setDescription = ["Beginner","Intermediate","Expert"]
        aquaman.currentSets = 3
    }
    
    //---------------------------------------------------------------------------------------------------------------------------
    //COLORS
    
    var colorArray = [WatchColor()]
    
    let preset1 = WatchColor()
    let preset2 = WatchColor()
    let preset3 = WatchColor()
    let preset4 = WatchColor()
    let preset5 = WatchColor()
    let preset6 = WatchColor()
    let preset7 = WatchColor()
    let preset8 = WatchColor()
    
    func startColors()
    {
        preset1.colorSet[0] = UIColor(hue: 0.865, saturation: 0.759, brightness: 0.163+0.4, alpha: 1)
        preset1.colorSet[1] = UIColor(hue: 0.625, saturation: 0.73, brightness: 0.59, alpha: 1)
        preset1.colorSet[2] = UIColor(hue: 0.09, saturation: 0.983, brightness: 0.461+0.4, alpha: 1)
        preset1.colorSet[3] = UIColor(hue: 0.136, saturation: 1, brightness: 0.486+0.4, alpha: 1)
        preset1.colorSet[4] = UIColor(hue: 0.187, saturation: 0.824, brightness: 0.333+0.4, alpha: 1)
        colorArray.append(preset1)
        
        preset2.colorSet[0] = UIColor(hue: 0.374, saturation: 0.164, brightness: 0.559+0.3, alpha: 1)
        preset2.colorSet[1] = UIColor(hue: 0.492, saturation: 0.408, brightness: 0.404+0.3, alpha: 1)
        preset2.colorSet[2] = UIColor(hue: 0.491, saturation: 0.79, brightness: 0.28+0.3, alpha: 1)
        preset2.colorSet[3] = UIColor(hue: 0.623, saturation: 0.358, brightness: 0.104+0.3, alpha: 1)
        preset2.colorSet[4] = UIColor(hue: 0.041, saturation: 0.804, brightness: 0.461+0.3, alpha: 1)
        colorArray.append(preset2)
        
        preset3.colorSet[0] = UIColor(hue: 0.064, saturation: 0.96, brightness: 0.494+0.2, alpha: 1)
        preset3.colorSet[1] = UIColor(hue: 0.111, saturation: 0.917, brightness: 0.527+0.2, alpha: 1)
        preset3.colorSet[2] = UIColor(hue: 0.095, saturation: 0.425, brightness: 0.829+0.2, alpha: 1)
        preset3.colorSet[3] = UIColor(hue: 0.47, saturation: 0.488, brightness: 0.51+0.2, alpha: 1)
        preset3.colorSet[4] = UIColor(hue: 0.064, saturation: 0.882, brightness: 0.133+0.2, alpha: 1)
        colorArray.append(preset3)
        
        preset4.colorSet[0] = UIColor(hue: 0.60, saturation: 0.111, brightness: 0.088+0.35, alpha: 1)
        preset4.colorSet[1] = UIColor(hue: 0.52, saturation: 0.474, brightness: 0.306+0.35, alpha: 1)
        preset4.colorSet[2] = UIColor(hue: 0.122, saturation: 0.71, brightness: 0.514+0.35, alpha: 1)
        preset4.colorSet[3] = UIColor(hue: 0.993, saturation: 0.792, brightness: 0.376+0.35, alpha: 1)
        preset4.colorSet[4] = UIColor(hue: 0.103, saturation: 0.121, brightness: 0.531+0.35, alpha: 1)
        colorArray.append(preset4)
        
        preset5.colorSet[0] = UIColor(hue: 0.523, saturation: 0.767, brightness: 0.371+0.2, alpha: 1)
        preset5.colorSet[1] = UIColor(hue: 0.178, saturation: 0.908, brightness: 0.873, alpha: 1)
        preset5.colorSet[2] = UIColor(hue: 0.172, saturation: 0.981, brightness: 0.41+0.2, alpha: 1)
        preset5.colorSet[3] = UIColor(hue: 0.075, saturation: 0.8, brightness: 0.51+0.2, alpha: 1)
        preset5.colorSet[4] = UIColor(hue: 0.961, saturation: 0.889, brightness: 0.424+0.2, alpha: 1)
        colorArray.append(preset5)
        
        preset6.colorSet[0] = UIColor(hue: 0.688, saturation: 0.8, brightness: 0.118+0.5, alpha: 1)
        preset6.colorSet[1] = UIColor(hue: 0.542, saturation: 0.842, brightness: 0.224+0.3, alpha: 1)
        preset6.colorSet[2] = UIColor(hue: 0.499, saturation: 0.938, brightness: 0.314+0.3, alpha: 1)
        preset6.colorSet[3] = UIColor(hue: 0.411, saturation: 0.427, brightness: 0.527+0.3, alpha: 1)
        preset6.colorSet[4] = UIColor(hue: 0.254, saturation: 0.583, brightness: 0.633+0.3, alpha: 1)
        colorArray.append(preset6)
        
        preset7.colorSet[0] = UIColor(hue: 0.741, saturation: 0.214, brightness: 0.329+0.2, alpha: 1)
        preset7.colorSet[1] = UIColor(hue: 0.215, saturation: 0.135, brightness: 0.551+0.2, alpha: 1)
        preset7.colorSet[2] = UIColor(hue: 0.432, saturation: 0.154, brightness: 0.408+0.2, alpha: 1)
        preset7.colorSet[3] = UIColor(hue: 0.531, saturation: 0.301, brightness: 0.28+0.2, alpha: 1)
        preset7.colorSet[4] = UIColor(hue: 0.742, saturation: 0.307, brightness: 0.198+0.2, alpha: 1)
        colorArray.append(preset7)
        
        preset8.colorSet[0] = UIColor(hue: 0.5, saturation: 1, brightness: 0.32+0.3, alpha: 1)
        preset8.colorSet[1] = UIColor(hue: 0.469, saturation: 0.907, brightness: 0.42+0.3, alpha: 1)
        preset8.colorSet[2] = UIColor(hue: 0.103, saturation: 0.908, brightness: 0.467+0.3, alpha: 1)
        preset8.colorSet[3] = UIColor(hue: 0.15, saturation: 0.935, brightness: 0.518+0.3, alpha: 1)
        preset8.colorSet[4] = UIColor(hue: 0.286, saturation: 1, brightness: 0.4+0.3, alpha: 1)
        colorArray.append(preset8)
    }
}

