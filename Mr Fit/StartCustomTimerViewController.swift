//
//  StartCustomTimerViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/16/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit
import AVFoundation

class StartCustomTimerViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var repetitionsLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var currentLabel: UILabel!
    
    
    var timer = Timer()
    var countDownNumber = 0
    var phase = "getReady"
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var rate: Float = 0.15
    var pitchMultiplier: Float = 1.0
    var volume: Float = 1.0
    
    let customExerciseTime = UserDefaults.standard.integer(forKey: "customExerciseTime")
    let customRestTime = UserDefaults.standard.integer(forKey: "customRestTime")
    let customRepetitions = UserDefaults.standard.integer(forKey: "customRepetitions")
    
    let mute = UserDefaults.standard.bool(forKey: "muteOnOrOff")
    
    var currentRepetition = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StartCustomTimerViewController.seconds), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if mute
        {
            volume = 0.0
        }
        
        let viewWidth: CGFloat = self.view.bounds.size.width
        let viewHeight: CGFloat = self.view.bounds.size.height
        
        self.titleLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.repetitionsLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.countdownLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.currentLabel.alpha = 0
        
        self.getReady()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        UIView.animateWithDuration(1, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.repetitionsLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.countdownLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.currentLabel.alpha = 1
            }, completion: nil)
    }
    
    
    func seconds()
    {
        if countDownNumber > 0
        {
            countDownNumber -= 1
            
            self.setTimerLabel()
            
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
                self.repetitionsLabel.text = "Repetitions: \(currentRepetition)-\(customRepetitions)"
                
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
                UIApplication.shared.isIdleTimerDisabled = false
                
                self.performSegue(withIdentifier: "cancelCustomWorkoutSegue",sender:self)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getReady()
    {
        self.countdownLabel.numberOfLines = 2
        
        self.repetitionsLabel.text = "Repetitions: 1-\(customRepetitions)"
        countDownNumber+=7
        self.setTimerLabel()
        self.currentLabel.text = "Get Ready!"
    }
    
    func startExercise()
    {
        self.view.backgroundColor = UIColor(red: 225/255, green: 245/255, blue: 196/255, alpha: 1)
        
        countDownNumber += customExerciseTime
        
        self.setTimerLabel()
        self.currentLabel.text = "Let's do it!"
    }
    
    func startWait()
    {
        //Blue Background
        self.view.backgroundColor = UIColor(hue: 0.572, saturation: 1, brightness: 0.771, alpha: 1)
        
        countDownNumber += customRestTime
        self.setTimerLabel()
        self.currentLabel.text = "Rest!"
    }
    
    func setTimerLabel()
    {
        if countDownNumber > 9
        {
            self.countdownLabel.text = "\(countDownNumber)"
        }
        else
        {
            self.countdownLabel.text = "0\(countDownNumber)"
        }
    }
    
    override func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {
        /*if whichVC == 0
        {
            whichVC = 1
            
            self.timer.invalidate()
            
            let speechUtterance = AVSpeechUtterance(string: "Pause")
            speechUtterance.rate = rate
            speechUtterance.pitchMultiplier = pitchMultiplier
            speechUtterance.volume = volume
            speechSynthesizer.speakUtterance(speechUtterance)
            
            self.performSegueWithIdentifier("showPause",sender:self)
        }*/
        
        let speechUtterance = AVSpeechUtterance(string: "Pause")
        speechUtterance.rate = rate
        speechUtterance.pitchMultiplier = pitchMultiplier
        speechUtterance.volume = volume
        speechSynthesizer.speak(speechUtterance)
        
        self.timer.invalidate()
        
        self.performSegue(withIdentifier: "pauseCustom",sender:self)
        
    }
    
    @IBAction func resumeCustomWorkout(_ segue:UIStoryboardSegue)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StartCustomTimerViewController.seconds), userInfo: nil, repeats: true)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
