//
//  CustomTimerViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/16/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class CustomTimerViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var exerciseTimeLabel: UILabel!
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var exerciseSlider: UISlider!
    
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var background2Label: UILabel!
    @IBOutlet weak var restSlider: UISlider!
    
    @IBOutlet weak var repetitionsLabel: UILabel!
    @IBOutlet weak var background3Label: UILabel!
    @IBOutlet weak var repetitionsSlider: UISlider!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    var customExerciseTime = UserDefaults.standard.integer(forKey: "customExerciseTime")
    var customRestTime = UserDefaults.standard.integer(forKey: "customRestTime")
    var customRepetitions = UserDefaults.standard.integer(forKey: "customRepetitions")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        exerciseSlider.value = Float(customExerciseTime)
        restSlider.value = Float(customRestTime)
        repetitionsSlider.value = Float(customRepetitions)
        
        exerciseTimeLabel.text = " Exercise Time: \(customExerciseTime)sec"
        restTimeLabel.text = " Rest Time: \(customRestTime)sec"
        repetitionsLabel.text = " Repetitions: \(customRepetitions)"
        
        self.calculateTotalTime()
        
        self.titleLabel.alpha = 0
        
        self.exerciseTimeLabel.alpha = 0
        self.backgroundLabel.alpha = 0
        self.exerciseSlider.alpha = 0
        
        self.restTimeLabel.alpha = 0
        self.background2Label.alpha = 0
        self.restSlider.alpha = 0
        
        self.repetitionsLabel.alpha = 0
        self.background3Label.alpha = 0
        self.repetitionsSlider.alpha = 0
        
        self.totalTimeLabel.alpha = 0
        
        self.startButton.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.titleLabel.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.exerciseTimeLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.backgroundLabel.alpha = 1
            self.exerciseSlider.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.restTimeLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.background2Label.alpha = 1
            self.restSlider.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 0.35, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.repetitionsLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.background3Label.alpha = 1
            self.repetitionsSlider.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 0.45, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.totalTimeLabel.alpha = 1
            }, completion: nil)
        
        UIView.animateWithDuration(1.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.startButton.alpha = 1
            }, completion: nil)
    }
    
    @IBAction func exerciseSliderChanged(_ sender: AnyObject)
    {
        self.customExerciseTime = Int(self.exerciseSlider.value)
        exerciseTimeLabel.text = " Exercise Time: \(customExerciseTime)sec"
        self.calculateTotalTime()
    }
    
    @IBAction func restSliderChanged(_ sender: AnyObject)
    {
        self.customRestTime = Int(self.restSlider.value)
        restTimeLabel.text = " Rest Time: \(customRestTime)sec"
        self.calculateTotalTime()
    }
    
    @IBAction func repetitionsSliderChanged(_ sender: AnyObject)
    {
        self.customRepetitions = Int(self.repetitionsSlider.value)
        repetitionsLabel.text = " Repetitions: \(customRepetitions)"
        self.calculateTotalTime()
    }
    
    @IBAction func startButtonPressed(_ sender: AnyObject)
    {
        UIApplication.shared.isIdleTimerDisabled = true
        
        UserDefaults.standard.set(customExerciseTime, forKey: "customExerciseTime")
        UserDefaults.standard.set(customRestTime, forKey: "customRestTime")
        UserDefaults.standard.set(customRepetitions, forKey: "customRepetitions")
        
        self.performSegue(withIdentifier: "startCustom",sender:self)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(customExerciseTime, forKey: "customExerciseTime")
        UserDefaults.standard.set(customRestTime, forKey: "customRestTime")
        UserDefaults.standard.set(customRepetitions, forKey: "customRepetitions")
    }
    
    @IBAction func cancelCustomWorkout(_ segue:UIStoryboardSegue)
    {
        
    }
    
    func calculateTotalTime()
    {
        let total = (customExerciseTime*customRepetitions)+(customRestTime*(customRepetitions-1))
        let segundos = total%60
        let minutos = (total-segundos)/60
        
        self.totalTimeLabel.text = "Total Time: \(minutos)min \(segundos)sec"
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
