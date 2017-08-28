//
//  WorkoutViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 3/29/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit
//import iAd
import AVFoundation

class WorkoutViewController: UIViewController/*, ADBannerViewDelegate*/ {

    @IBOutlet weak var setLabel: UILabel!
    @IBOutlet weak var exerciseNumberLabel: UILabel!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var nextExerciseLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    @IBOutlet weak var bannerAdjustConstraint: NSLayoutConstraint!
    
    var countDownNumber = 0
    var currentExercise = 0
    var currentRep = 1
    var phase = "getReady"
    
    var timer = Timer()
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var rate: Float = 0.15
    var pitchMultiplier: Float = 1.0
    var volume: Float = 1.0
    
    let repWaitTime = UserDefaults.standard.integer(forKey: "setWaitTime")
    let exerciseWaitTime = UserDefaults.standard.integer(forKey: "exerciseWaitTime")
    let mute = UserDefaults.standard.bool(forKey: "muteOnOrOff")
    
    var earnedScore = 0
    
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if mute
        {
            volume = 0.0
        }
        
        if self.repWaitTime == 0
        {
            UserDefaults.standard.set(4, forKey: "setWaitTime")
            self.repWaitTime == 4
        }
        
        //-------------iAd Banner----------------------
        var banner = UserDefaults.standard.integer(forKey: "EraseInfo")
        if banner != 718
        {
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                self.bannerAdjustConstraint.constant = 66
            }
            else
            {
                self.bannerAdjustConstraint.constant = 50
            }
            
            var sharedBanner = BannerManager.sharedInstance.sharedBanner
            
            var SH = UIScreen.main.bounds.height
            
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                sharedBanner.frame = CGRect(x: 0, y: SH-66, width: 0, height: 0)
            }
            else
            {
                sharedBanner.frame = CGRect(x: 0, y: SH-50, width: 0, height: 0)
            }
            self.view.addSubview(sharedBanner)
            println("Banner Added")
        }
        else
        {
            self.bannerAdjustConstraint.constant = 0
        }
        
        if BannerManager.sharedInstance.cargo == false
        {
            self.bannerAdjustConstraint.constant = 0
        }
        //---------------------------------------------
        
        self.getReady()
        
        let viewWidth: CGFloat = self.view.bounds.size.width
        let viewHeight: CGFloat = self.view.bounds.size.height
        
        self.setLabel.transform = CGAffineTransform(translationX: 0, y: -viewHeight)
        self.exerciseNumberLabel.transform = CGAffineTransform(translationX: 0, y: -viewHeight)
        self.exerciseNameLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.nextExerciseLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        //self.timerLabel.transform = CGAffineTransformMakeTranslation(0, -viewHeight)
        self.timerLabel.alpha = 0
        self.exerciseImage.alpha = 0
        
        
        self.exerciseImage.image = UIImage(named: "\(AppManager.sharedInstance.cualExercise.exercises[currentExercise])")
    }
    
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    override func viewDidAppear(_ animated: Bool)
    {
        UIView.animate(withDuration: 0.7, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.timerLabel.alpha = 1.0
            }, completion: nil)
        /*UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.timerLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)*/
        UIView.animateWithDuration(1.5, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.setLabel.transform = CGAffineTransformMakeTranslation(0, 0)
            self.exerciseNumberLabel.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.exerciseNameLabel.transform = CGAffineTransformMakeTranslation(0, 0)
            self.nextExerciseLabel.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.15, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.exerciseImage.alpha = 1.0
            }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutViewController.seconds), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func seconds()
    {
        if BannerManager.sharedInstance.cargo == false
        {
            self.bannerAdjustConstraint.constant = 0
        }
        else
        {
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                self.bannerAdjustConstraint.constant = 66
            }
            else
            {
                self.bannerAdjustConstraint.constant = 50
            }
        }
        
        if countDownNumber > 0
        {
            countDownNumber -= 1
            
            if phase != "getReady" && phase != "wait"
            {
                earnedScore += 1
            }
            
            if countDownNumber > 9
            {
                self.timerLabel.text = "\(countDownNumber)"
            }
            else
            {
                self.timerLabel.text = "0\(countDownNumber)"
            }
            
            if countDownNumber == 5 && phase == "getReady"
            {
                let speechUtterance = AVSpeechUtterance(string: "Get ready for \(AppManager.sharedInstance.cualExercise.exercises[currentExercise])")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            
            if countDownNumber == 1
            {
                let speechUtterance = AVSpeechUtterance(string: "1")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            else if countDownNumber == 2
            {
                let speechUtterance = AVSpeechUtterance(string: "2")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            else if countDownNumber == 3
            {
                let speechUtterance = AVSpeechUtterance(string: "3")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            else if countDownNumber == 4 && phase != "getReady" && phase != "wait"
            {
                let speechUtterance = AVSpeechUtterance(string: "4")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            else if countDownNumber == 5 && phase != "getReady" && phase != "wait"
            {
                let speechUtterance = AVSpeechUtterance(string: "5")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            
            if countDownNumber == 25 && (phase == "exercise" || phase == "lastExercise")
            {
                let speechUtterance = AVSpeechUtterance(string: "25 seconds left")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            
            if countDownNumber == 20 && (phase == "exercise" || phase == "lastExercise")
            {
                let speechUtterance = AVSpeechUtterance(string: "20 seconds left")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            
            if countDownNumber == 15 && (phase == "exercise" || phase == "lastExercise")
            {
                let speechUtterance = AVSpeechUtterance(string: "15 seconds left")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            
            if countDownNumber == 10 && (phase == "exercise" || phase == "lastExercise")
            {
                let speechUtterance = AVSpeechUtterance(string: "10 seconds left")
                speechUtterance.rate = rate
                speechUtterance.pitchMultiplier = pitchMultiplier
                speechUtterance.volume = volume
                speechSynthesizer.speak(speechUtterance)
            }
            
        }
        if countDownNumber == 0
        {
            if phase == "getReady"
            {
                if AppManager.sharedInstance.cualExercise.exercises.count>1
                {
                    phase = "exercise"
                    startExercise()
                }
                else
                {
                    phase = "lastExercise"
                    startLastExercise()
                }
            }
            else if phase == "exercise"
            {
                phase = "wait"
                startWait()
                
                self.exerciseImage.image = UIImage(named: "\(AppManager.sharedInstance.cualExercise.exercises[currentExercise+1])")
            }
            else if phase == "wait"
            {
                currentExercise += 1
                
                if currentExercise == AppManager.sharedInstance.cualExercise.exercises.count-1
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
                if currentRep == AppManager.sharedInstance.cualExercise.currentSets
                {
                    phase = "finished"
                    currentExercise = 0
                    
                    AppManager.sharedInstance.earnedScore = self.earnedScore
                    AppManager.sharedInstance.workoutScore+=self.earnedScore
                    UserDefaults.standard.setSecretInteger(AppManager.sharedInstance.workoutScore, forKey: "workoutScore")
                    
                    let currentUser = PFUser.currentUser()
                    if (currentUser != nil)
                    {
                        currentUser?["Score"] = AppManager.sharedInstance.workoutScore
                        currentUser?.saveEventually()
                    }
                    
                    println("hay \(AppManager.sharedInstance.dailyWorkout.count) elementos")
                    
                    let lastItem = AppManager.sharedInstance.dailyWorkout.count
                    
                    if lastItem == 0
                    {
                        println("dates estan vacios")
                        let today = [Date(),self.earnedScore] as [Any]
                        AppManager.sharedInstance.dailyWorkout.append(today as NSArray)
                    }
                    else
                    {
                        let dateArray = AppManager.sharedInstance.dailyWorkout[lastItem-1]
                        
                        let pastDate = dateArray[0] as! Date
                        let currentDate = Date()
                        
                        let pastScore = dateArray[1] as! Int
                        
                        let calender = Calendar.current
                        let components = calender.components(NSCalendar.Unit.CalendarUnitDay, fromDate: currentDate, toDate: pastDate, options: nil).day
                        println("dias de por medio: \(components)")
                        
                        if components == 0
                        {
                            let totalScore = self.earnedScore+pastScore
                            
                            let today = [pastDate,totalScore] as [Any]
                            AppManager.sharedInstance.dailyWorkout[lastItem-1] = today as NSArray
                        }
                        else
                        {
                            let today = [Date(),self.earnedScore] as [Any]
                            AppManager.sharedInstance.dailyWorkout.append(today as NSArray)
                        }
                        
                    }
                    
                    UserDefaults.standard.set(AppManager.sharedInstance.dailyWorkout, forKey: "dailyWorkout")
                    
                    self.earnedScore = 0
                    self.volume = 0.0
                    self.performSegue(withIdentifier: "showFinished",sender:self)
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
        //Orange Background
        self.view.backgroundColor = UIColor(hue: 0.119, saturation: 0.93, brightness: 1, alpha: 1)
        
        self.exerciseNameLabel.text = "Get ready!"
        self.nextExerciseLabel.text = "NEXT: \(AppManager.sharedInstance.cualExercise.exercises[currentExercise])"
        self.setLabel.text = "Set: \(currentRep)-\(AppManager.sharedInstance.cualExercise.currentSets)"
        self.exerciseNumberLabel.text = "Exercise: \(currentExercise)-\(AppManager.sharedInstance.cualExercise.exercises.count)"
        countDownNumber+=7
        if countDownNumber > 9
        {
            self.timerLabel.text = "\(countDownNumber)"
        }
        else
        {
            self.timerLabel.text = "0\(countDownNumber)"
        }
    }
    
    func startExercise()
    {
        //Orange Background
        self.view.backgroundColor = UIColor(hue: 0.119, saturation: 0.93, brightness: 1, alpha: 1)
        
        self.exerciseNameLabel.text = "\(AppManager.sharedInstance.cualExercise.exercises[currentExercise])"
        self.nextExerciseLabel.text = "NEXT: \(AppManager.sharedInstance.cualExercise.exercises[currentExercise+1])"
        self.setLabel.text = "Set: \(currentRep)-\(AppManager.sharedInstance.cualExercise.currentSets)"
        self.exerciseNumberLabel.text = "Exercise: \(currentExercise+1)-\(AppManager.sharedInstance.cualExercise.exercises.count)"
        countDownNumber += AppManager.sharedInstance.cualExercise.exerciseTimes[currentExercise]
        
        if countDownNumber > 9
        {
            self.timerLabel.text = "\(countDownNumber)"
        }
        else
        {
            self.timerLabel.text = "0\(countDownNumber)"
        }
    }
    
    func startLastExercise()
    {
        //Orange Background
        self.view.backgroundColor = UIColor(hue: 0.119, saturation: 0.93, brightness: 1, alpha: 1)
        
        self.exerciseNameLabel.text = "\(AppManager.sharedInstance.cualExercise.exercises[currentExercise])"
        self.nextExerciseLabel.text = "Almost finished!"
        self.setLabel.text = "Set: \(currentRep)-\(AppManager.sharedInstance.cualExercise.currentSets)"
        self.exerciseNumberLabel.text = "Exercise: \(currentExercise+1)-\(AppManager.sharedInstance.cualExercise.exercises.count)"
        countDownNumber += AppManager.sharedInstance.cualExercise.exerciseTimes[currentExercise]
        if countDownNumber > 9
        {
            self.timerLabel.text = "\(countDownNumber)"
        }
        else
        {
            self.timerLabel.text = "0\(countDownNumber)"
        }
    }
    
    func startWait()
    {
        //Blue Background
        self.view.backgroundColor = UIColor(hue: 0.572, saturation: 1, brightness: 0.771, alpha: 1)
        
        self.exerciseNameLabel.text = "REST!"
        countDownNumber += (AppManager.sharedInstance.cualExercise.waitTimes[currentExercise]+self.exerciseWaitTime)
        if countDownNumber > 9
        {
            self.timerLabel.text = "\(countDownNumber)"
        }
        else
        {
            self.timerLabel.text = "0\(countDownNumber)"
        }
        
        let speechUtterance = AVSpeechUtterance(string: "Get ready for \(AppManager.sharedInstance.cualExercise.exercises[currentExercise+1])")
        speechUtterance.rate = rate
        speechUtterance.pitchMultiplier = pitchMultiplier
        speechUtterance.volume = volume
        speechSynthesizer.speak(speechUtterance)
    }
    
    func startRepWait()
    {
        //Blue Background
        self.view.backgroundColor = UIColor(hue: 0.572, saturation: 1, brightness: 0.771, alpha: 1)
        
        self.exerciseNameLabel.text = "Rest for next rep!"
        self.nextExerciseLabel.text = "NEXT: \(AppManager.sharedInstance.cualExercise.exercises[currentExercise])"
        self.setLabel.text = "Set: \(currentRep)-\(AppManager.sharedInstance.cualExercise.currentSets)"
        self.exerciseNumberLabel.text = "Exercise: 0-\(AppManager.sharedInstance.cualExercise.exercises.count)"
        countDownNumber += self.repWaitTime*30
        if countDownNumber > 9
        {
            self.timerLabel.text = "\(countDownNumber)"
        }
        else
        {
            self.timerLabel.text = "0\(countDownNumber)"
        }
        
        var speech = ""
        if AppManager.sharedInstance.cualExercise.currentSets-currentRep+1 == 1
        {
            speech = "Good Job. You have 1 repetition remaining."
        }
        else
        {
            speech = "Good Job. You have \(AppManager.sharedInstance.cualExercise.currentSets-currentRep+1) repetitions remaining."
        }
        
        let speechUtterance = AVSpeechUtterance(string: speech)
        speechUtterance.rate = rate
        speechUtterance.pitchMultiplier = pitchMultiplier
        speechUtterance.volume = volume
        speechSynthesizer.speak(speechUtterance)
    }
    
    var whichVC = 0
    
    override func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {
        if whichVC == 0
        {
            whichVC = 1
            
            self.timer.invalidate()
            
            /*let speechUtterance = AVSpeechUtterance(string: "Pause")
            speechUtterance.rate = rate
            speechUtterance.pitchMultiplier = pitchMultiplier
            speechUtterance.volume = volume
            speechSynthesizer.speakUtterance(speechUtterance)*/
            
            self.performSegue(withIdentifier: "showPause",sender:self)
        }
    }
    
    @IBAction func resumeWorkout(_ segue:UIStoryboardSegue)
    {
        if AppManager.sharedInstance.skip == true
        {
            println("entro a skip")
            
            countDownNumber = 1
            AppManager.sharedInstance.skip == false
            
            /*let speechUtterance = AVSpeechUtterance(string: "Skip")
            speechUtterance.rate = rate
            speechUtterance.pitchMultiplier = pitchMultiplier
            speechUtterance.volume = volume
            speechSynthesizer.speakUtterance(speechUtterance)*/
        }
        
        else if AppManager.sharedInstance.skip == false
        {
            println("entro a resume")
            
            /*let speechUtterance = AVSpeechUtterance(string: "Resume")
            speechUtterance.rate = rate
            speechUtterance.pitchMultiplier = pitchMultiplier
            speechUtterance.volume = volume
            speechSynthesizer.speakUtterance(speechUtterance)*/
        }
        
        whichVC = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(WorkoutViewController.seconds), userInfo: nil, repeats: true)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
