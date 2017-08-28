//
//  AppManager.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 3/28/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class AppManager {

    private static var __once: () = {
            Static.instance = AppManager()
        }()

    class var sharedInstance: AppManager {
        struct Static {
            static var instance: AppManager?
            static var token: Int = 0
        }
        
        _ = AppManager.__once
        
        return Static.instance!
    }
    
    var skip = false
    
    var cualExercise = Routine()
    var cualesColores = PresetColor()
    
    let phrases = [
        "''You have to do what others won't, to achieve what others don't.''",
        "''The distance between who I am and who I want to be, is only separated by my actions and words''",
        "''The only bad workout is the one that didn't happen.''",
        "''Change your thoughts and you will change your world.''",
        "''It's actually pretty simply. Either you do it, or you don't.''",
        "''Do something that makes you happy.''",
        "''Don't lose faith, you got this.''",
        "''If you don't go after what you want, you will never have it.''",
        "''Life's only limitations are the ones we make.''",
        "''The only way to finish is to start.''",
        "''You don't always get what you wish for. You get what you work for.''"
    ]
    
    let menuItems = [">>>SCORE",">>>WORKOUTS","> 7 Minute Workout","> Advanced 7 Minute","> Perfect Six Pack","> The Dark Knight","> In a Hurry Abs","> Need Legs?","> The Soldier","> The Samurai","> Full Fit","> Daily Quickie","> Random","> Custom"]
    
    let otherItems = [">>>OTHER","> Ultimate Purchase","> Social","> Custom Timer","> Exercise Log","> Weight Log","> Reminders","> Settings"]
    let otherItemsBought = [">>>OTHER","> Social","> Custom Timer","> Exercise Log","> Weight Log","> Reminders","> Settings"]
    
    var amount = 8+1
    
    var workoutScore = 0
    var earnedScore = 0
    
    var muteOnOrOff = false
    var kgOrLb = false
    
    var dailyWorkout:[NSArray] = []
    
    var dailyWeight:[NSArray] = []
    
    var leaderboardFriends = []
    
    var remindersOnOrOff = UserDefaults.standard.integer(forKey: "reminderOnOrOff")
    
    var amountOfCustomExercises = 0
    
    var customOrNot = 1
    
    //---------------------------------------------------------------------------------------------------------------------------
    //START
    
    var banner = UserDefaults.standard.secretInteger(forKey: "EraseAppData")
    
    var customWorkoutExercises: [String] = []
    var customWorkoutTimes: [Int] = []
    var customWorkoutWait: [Int] = []
    
    func start()
    {
        self.workoutScore = UserDefaults.standard.secretInteger(forKey: "workoutScore")
        
        let value = UserDefaults.standard.integer(forKey: "setWaitTime")
        var exerciseWaitTime = UserDefaults.standard.integer(forKey: "exerciseWaitTime")
        
        let customExerciseTime = UserDefaults.standard.integer(forKey: "customExerciseTime")
        let customRestTime = UserDefaults.standard.integer(forKey: "customRestTime")
        let customRepetitions = UserDefaults.standard.integer(forKey: "customRepetitions")
        
        let amountCustomExercises = UserDefaults.standard.integer(forKey: "amountCustomExercises")
        
        self.muteOnOrOff = UserDefaults.standard.bool(forKey: "muteOnOrOff")
        self.kgOrLb = UserDefaults.standard.bool(forKey: "kgOrLb")
        
        //NSUserDefaults.standardUserDefaults().setObject(dailyWorkout, forKey: "dailyWorkout")
        
        if let dailyWorkouts = UserDefaults.standard.array(forKey: "dailyWorkout")
        {
            dailyWorkout = dailyWorkouts as! [NSArray]
            
            //println("\(dailyWorkout)")
        }
        else
        {
            UserDefaults.standard.set(dailyWorkout, forKey: "dailyWorkout")
            //println("no encontro tiempos entonces guardo")
        }
        
        if let dailyWeights = UserDefaults.standard.array(forKey: "dailyWeight")
        {
            dailyWeight = dailyWeights as! [NSArray]
            
            //println("\(dailyWeight)")
        }
        else
        {
            UserDefaults.standard.set(dailyWeight, forKey: "dailyWeight")
            //println("no encontro pesos entonces guardo")
        }
        
        
        //SETTINGS//--------------------------------------------------------------------------------
        if value == 0
        {
            UserDefaults.standard.set(4, forKey: "setWaitTime")
        }
        if banner == 0
        {
            UserDefaults.standard.setSecretInteger(613, forKey: "EraseAppData")
            
            //NSUserDefaults.standardUserDefaults().setInteger(613, forKey: "EraseInfo")
            banner = 613
        }
        
        if UserDefaults.standard.secretBool(forKey: "CompleteApp") == false
        {
            UserDefaults.standard.setSecretBool(true, forKey: "CompleteApp")
            
            UserDefaults.standard.setSecretInteger(718, forKey: "EraseAppData")
            banner = 718
            let sharedDefaults = UserDefaults(suiteName: "group.com.MrFit.shared")
            sharedDefaults?.set(5201, forKey: "ArmInfo")
        }
        
        if UserDefaults.standard.secretBool(forKey: "CompleteApp") == true
        {
            UserDefaults.standard.setSecretInteger(718, forKey: "EraseAppData")
            banner = 718
            let sharedDefaults = UserDefaults(suiteName: "group.com.MrFit.shared")
            sharedDefaults?.set(5201, forKey: "ArmInfo")
        }
        
        
        //CUSTOM TIMER//--------------------------------------------------------------------------------
        if customExerciseTime == 0
        {
            UserDefaults.standard.set(10, forKey: "customExerciseTime")
        }
        if customRestTime == 0
        {
            UserDefaults.standard.set(5, forKey: "customRestTime")
        }
        if customRepetitions == 0
        {
            UserDefaults.standard.set(1, forKey: "customRepetitions")
        }
        
        //CUSTOM WORKOUT//--------------------------------------------------------------------------------
        if amountCustomExercises == 0
        {
            UserDefaults.standard.set(10, forKey: "amountCustomExercises")
        }
        
        //CUSTOM EXERCISES WORKOUT//----------------------------------------------------------------------
        
        let customWorkoutExercises1: AnyObject? = UserDefaults.standard.object(forKey: "customWorkoutExercises") as AnyObject
        let customWorkoutTimes1: AnyObject? = UserDefaults.standard.object(forKey: "customWorkoutTimes") as AnyObject
        let customWorkoutWait1: AnyObject? = UserDefaults.standard.object(forKey: "customWorkoutWait") as AnyObject
        
        if customWorkoutExercises1 == nil
        {
            UserDefaults.standard.set(["Jumping Jacks"], forKey: "customWorkoutExercises")
            customWorkoutExercises = ["Jumping Jacks"]
        }
        if customWorkoutTimes1 == nil
        {
            UserDefaults.standard.set([30], forKey: "customWorkoutTimes")
            customWorkoutTimes = [30]
        }
        if customWorkoutWait1 == nil
        {
            UserDefaults.standard.set([5], forKey: "customWorkoutWait")
            customWorkoutWait = [5]
        }
        if customWorkoutExercises.isEmpty
        {
            customWorkoutExercises = ["Jumping Jacks"]
        }
        if customWorkoutTimes.isEmpty
        {
            customWorkoutTimes = [30]
        }
        if customWorkoutWait.isEmpty
        {
            customWorkoutWait = [5]
        }
        
        self.startWorkouts()
        self.startColors()
    }
    
    //---------------------------------------------------------------------------------------------------------------------------
    //ALL EXERCISES
    
    let allExercises = [
        "Jumping Jacks","Wall Sits","Push-ups","Crunches","Step up onto Chair","Squats","Triceps dip on Chair","Elbow Plank","High knees running in place","Lunges","Push-up and rotation","Side Plank","Long arm crunches","Air bike crunches","Reverse crunches","Cross crunches","Knee crunches","Flutter kicks","Scissors","Hundreds","Sitting Twists","Shoulder Taps","Climbers","Sit-up Punches","Punches","Jumping Lunges","Leg Raises","Side Leg Raises","Split Squats","Pull-ups","Chest Expansion","Turning Kicks","Plank Arm Raises","Windshield Wipers","Get-ups","Diver Push-ups"
    ]
    
    //---------------------------------------------------------------------------------------------------------------------------
    //WORKOUT
    
    let original = Routine()
    let steelAbs = Routine()
    let twoMinAbs = Routine()
    let batman = Routine()
    let legDay = Routine()
    let navySeal = Routine()
    let ninja = Routine()
    let aquaman = Routine()
    //NEW--------------------------
    let quickie = Routine()
    let advanced = Routine()
    
    var random = Routine()
    var custom = Routine()
    
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
        twoMinAbs.waitTimes = [5,5,5,5,5,5]
        twoMinAbs.sets = [1,2,3,4,5]
        twoMinAbs.setWaitTime = 60
        twoMinAbs.setDescription = ["Basic","Starter","Intermediate","Expert","Let's do it"]
        twoMinAbs.currentSets = 1
        
        batman.name = "The Dark Knight"
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
        
        quickie.name = "Daily Quickie"
        quickie.exercises = ["Lunges","Air bike crunches","Squats","Reverse crunches","Push-ups","Superman","Plank","Side Plank"]
        quickie.exerciseTimes = [30,30,30,30,30,30,15,15]
        quickie.waitTimes = [5,5,5,5,5,5,5,5]
        quickie.sets = [1,2,3]
        quickie.setWaitTime = 60
        quickie.setDescription = ["Beginner","Intermediate","Expert"]
        quickie.currentSets = 1
        
        advanced.name = "Advanced 7"
        advanced.exercises = ["High knees running in place","Burpees","Plank","Long arm crunches","Push-ups","Squats","Lunges","Leg Raises","Jumping Lunges","Plank"]
        advanced.exerciseTimes = [40,40,40,40,40,40,40,40,40,40]
        advanced.waitTimes = [5,5,5,5,5,5,5,5,5,5]
        advanced.sets = [1,2,3]
        advanced.setWaitTime = 60
        advanced.setDescription = ["Beginner","Intermediate","Expert"]
        advanced.currentSets = 1
        
        random.name = "Random!"
        random.sets = [1,2,3,4,5,6,7,8,9,10]
        random.setDescription = ["","","","","","","","","",""]
        random.currentSets = 1
        random.setWaitTime = 60
        
        custom.name = "Custom Workout"
        custom.sets = [1,2,3,4,5,6,7,8,9,10]
        custom.setDescription = ["","","","","","","","","",""]
        custom.currentSets = 1
        custom.setWaitTime = 60
        
        original.routineDescription = "This scientifically proven workout is a 12-exercise based program. They are high intensity exercises that will boost your metabolism and make you burn body fat much faster! \n\nTrain your whole body."
        steelAbs.routineDescription = "Want the perfect, strongest and most awesome abs for summer? Try out this intense workout and quickly start improving your body's core! \n\nTrain your upper, lower and lateral abs."
        twoMinAbs.routineDescription = "In a hurry but don't want to lose your daily abs workout? Try out this quick and simple workout! \n\nTrain your upper, lower and lateral abs."
        batman.routineDescription = "Crime fighting is serious stuff! Be prepared for anything the night might have in store for you! Get ready to defend Gotham City! \n\nTrain your lower, upper and lateral abs, your chest and shoulders, your biceps, triceps, quads and glutes."
        legDay.routineDescription = "Never ever ever skip leg day again! This quick workout will exercise your legs and keep you prepared for anything! \n\nTrains quads, hamstrings, glutes and lower back."
        navySeal.routineDescription = "Keep your body strong like steel and ready for anything! Need to swim, run, fight or jump of an airplane? This is the workout you need. \n\nTrains your triceps, biceps, upper and lateral abs, quads, glutes and helps the respiratory system."
        ninja.routineDescription = "Silent like the night and cat-like stealth. Train your body to become the perfect Samurai! \n\nTrains your quads, lower back, lateral abs and lateral hip flexors, shoulders, triceps, chest and core."
        aquaman.routineDescription = "Don't have time for various muscle specific workouts? Try this all in one routine and train your whole body! Feel your body burn with strength!\n\nTrains your lateral, and lower abs, shoulders, lower back, chest, shoulders, biceps, triceps, glutes and quads."
        
        quickie.routineDescription = ""
        advanced.routineDescription = ""
        
        random.routineDescription = "Completely random set of exercises!"
        custom.routineDescription = "NIL"
    }
    
    //---------------------------------------------------------------------------------------------------------------------------
    //COLORS
    
    let preset1 = PresetColor()
    let preset2 = PresetColor()
    let preset3 = PresetColor()
    let preset4 = PresetColor()
    let preset5 = PresetColor()
    let preset6 = PresetColor()
    let preset7 = PresetColor()
    let preset8 = PresetColor()
    
    var randomPreset = PresetColor()
    
    func startColors()
    {
        preset1.colorSet[0] = UIColor(hue: 0.865, saturation: 0.759, brightness: 0.163+0.4, alpha: 1)
        preset1.colorSet[1] = UIColor(hue: 0.625, saturation: 0.73, brightness: 0.59, alpha: 1)
        preset1.colorSet[2] = UIColor(hue: 0.09, saturation: 0.983, brightness: 0.461+0.4, alpha: 1)
        preset1.colorSet[3] = UIColor(hue: 0.136, saturation: 1, brightness: 0.486+0.4, alpha: 1)
        preset1.colorSet[4] = UIColor(hue: 0.187, saturation: 0.824, brightness: 0.333+0.4, alpha: 1)
        
        preset2.colorSet[0] = UIColor(hue: 0.374, saturation: 0.164, brightness: 0.559+0.3, alpha: 1)
        preset2.colorSet[1] = UIColor(hue: 0.492, saturation: 0.408, brightness: 0.404+0.3, alpha: 1)
        preset2.colorSet[2] = UIColor(hue: 0.491, saturation: 0.79, brightness: 0.28+0.3, alpha: 1)
        preset2.colorSet[3] = UIColor(hue: 0.623, saturation: 0.358, brightness: 0.104+0.3, alpha: 1)
        preset2.colorSet[4] = UIColor(hue: 0.041, saturation: 0.804, brightness: 0.461+0.3, alpha: 1)
        
        preset3.colorSet[0] = UIColor(hue: 0.064, saturation: 0.96, brightness: 0.494+0.2, alpha: 1)
        preset3.colorSet[1] = UIColor(hue: 0.111, saturation: 0.917, brightness: 0.527+0.2, alpha: 1)
        preset3.colorSet[2] = UIColor(hue: 0.095, saturation: 0.425, brightness: 0.829+0.2, alpha: 1)
        preset3.colorSet[3] = UIColor(hue: 0.47, saturation: 0.488, brightness: 0.51+0.2, alpha: 1)
        preset3.colorSet[4] = UIColor(hue: 0.064, saturation: 0.882, brightness: 0.133+0.2, alpha: 1)
        
        preset4.colorSet[0] = UIColor(hue: 0.60, saturation: 0.111, brightness: 0.088+0.35, alpha: 1)
        preset4.colorSet[1] = UIColor(hue: 0.52, saturation: 0.474, brightness: 0.306+0.35, alpha: 1)
        preset4.colorSet[2] = UIColor(hue: 0.122, saturation: 0.71, brightness: 0.514+0.35, alpha: 1)
        preset4.colorSet[3] = UIColor(hue: 0.993, saturation: 0.792, brightness: 0.376+0.35, alpha: 1)
        preset4.colorSet[4] = UIColor(hue: 0.103, saturation: 0.121, brightness: 0.531+0.35, alpha: 1)
        
        preset5.colorSet[0] = UIColor(hue: 0.523, saturation: 0.767, brightness: 0.371+0.2, alpha: 1)
        preset5.colorSet[1] = UIColor(hue: 0.178, saturation: 0.908, brightness: 0.873, alpha: 1)
        preset5.colorSet[2] = UIColor(hue: 0.172, saturation: 0.981, brightness: 0.41+0.2, alpha: 1)
        preset5.colorSet[3] = UIColor(hue: 0.075, saturation: 0.8, brightness: 0.51+0.2, alpha: 1)
        preset5.colorSet[4] = UIColor(hue: 0.961, saturation: 0.889, brightness: 0.424+0.2, alpha: 1)
        
        preset6.colorSet[0] = UIColor(hue: 0.688, saturation: 0.8, brightness: 0.118+0.5, alpha: 1)
        preset6.colorSet[1] = UIColor(hue: 0.542, saturation: 0.842, brightness: 0.224+0.3, alpha: 1)
        preset6.colorSet[2] = UIColor(hue: 0.499, saturation: 0.938, brightness: 0.314+0.3, alpha: 1)
        preset6.colorSet[3] = UIColor(hue: 0.411, saturation: 0.427, brightness: 0.527+0.3, alpha: 1)
        preset6.colorSet[4] = UIColor(hue: 0.254, saturation: 0.583, brightness: 0.633+0.3, alpha: 1)
        
        preset7.colorSet[0] = UIColor(hue: 0.741, saturation: 0.214, brightness: 0.329+0.2, alpha: 1)
        preset7.colorSet[1] = UIColor(hue: 0.215, saturation: 0.135, brightness: 0.551+0.2, alpha: 1)
        preset7.colorSet[2] = UIColor(hue: 0.432, saturation: 0.154, brightness: 0.408+0.2, alpha: 1)
        preset7.colorSet[3] = UIColor(hue: 0.531, saturation: 0.301, brightness: 0.28+0.2, alpha: 1)
        preset7.colorSet[4] = UIColor(hue: 0.742, saturation: 0.307, brightness: 0.198+0.2, alpha: 1)
        
        preset8.colorSet[0] = UIColor(hue: 0.5, saturation: 1, brightness: 0.32+0.3, alpha: 1)
        preset8.colorSet[1] = UIColor(hue: 0.469, saturation: 0.907, brightness: 0.42+0.3, alpha: 1)
        preset8.colorSet[2] = UIColor(hue: 0.103, saturation: 0.908, brightness: 0.467+0.3, alpha: 1)
        preset8.colorSet[3] = UIColor(hue: 0.15, saturation: 0.935, brightness: 0.518+0.3, alpha: 1)
        preset8.colorSet[4] = UIColor(hue: 0.286, saturation: 1, brightness: 0.4+0.3, alpha: 1)
    }
    
    //---------------------------------------------------------------------------------------------------------------------------
    
    func randomize()
    {
        let colorArray:[PresetColor] = [preset1,preset2,preset3,preset4,preset5,preset6,preset7,preset8]
        let whichOne = Int(arc4random_uniform(8))
        randomPreset = colorArray[whichOne]
        
        let amountOfCustomExercises = UserDefaults.standard.integer(forKey: "amountCustomExercises")
        
        var customExercises = allExercises
        var currentCustomExercises:[String] = []
        var currentExerciseTimes:[Int] = []
        var currentWaitTimes:[Int] = []
        
        for i in 0  ..< amountOfCustomExercises += 1
        {
            let random = Int(arc4random_uniform(UInt32(customExercises.count)))
            
            let randomExercise = customExercises[random]
            customExercises.remove(at: random)
            
            currentCustomExercises.append(randomExercise)
            
            currentExerciseTimes.append(30)
            currentWaitTimes.append(5)
        }
        
        random.exercises = currentCustomExercises
        random.exerciseTimes = currentExerciseTimes
        random.waitTimes = currentWaitTimes
    }
    
    //---------------------------------------------------------------------------------------------------------------------------
    
    func obtainUserNameAndFbId()
    {
        let currentUser = PFUser.currentUser()
        
        if currentUser == nil
        {
            println("NO user signed in")
            return
        }
        else
        {
            if let fbId = currentUser?["fbId"] as? String
            {
                if !fbId.isEmpty
                {
                    println("we already have a username and fbId -> return")
                    return
                }
            }
        }
        
        println("Performing request to FB for username and Id...")
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                if (error == nil)
                {
                    let name = result["name"] as! String
                    let fbId = result["id"]
                    let email = result["email"] as! String
                    
                    println("Name: \(name)")
                    println("Id: \(fbId)")
                    println("Email: \(email)")
                    
                    currentUser?.username = name
                    currentUser?["fbId"] = fbId
                    currentUser?.email = email
                    currentUser?["Score"] = self.workoutScore
                    currentUser?.saveEventually()
                }
                else
                {
                    println("\(error.localizedDescription)")
                }
            })
        }
    }
}
