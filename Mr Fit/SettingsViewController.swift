//
//  SettingsViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 4/13/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var changeTimeLabel: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!
    
    @IBOutlet weak var increaseTimeLabel: UILabel!
    @IBOutlet weak var sliderLabel2: UILabel!
    @IBOutlet weak var increaseLabel: UISlider!
    @IBOutlet weak var timeLabel2: UILabel!
    
    @IBOutlet weak var exerciseVoiceLabel: UILabel!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var unmuteButton: UIButton!
    
    @IBOutlet weak var weightUnitsLabel: UILabel!
    @IBOutlet weak var kgUnitButton: UIButton!
    @IBOutlet weak var lbUnitButton: UIButton!
    
    @IBOutlet weak var amountCustomExercises: UILabel!
    @IBOutlet weak var sliderLabel3: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountSlider: UISlider!
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    
    
    //let defaults1 = NSUserDefaults.standardUserDefaults()
    var value = UserDefaults.standard.integer(forKey: "setWaitTime")
    var increase = UserDefaults.standard.integer(forKey: "exerciseWaitTime")
    
    //var mute = NSUserDefaults.standardUserDefaults().boolForKey("muteOnOrOff")
    var mute = AppManager.sharedInstance.muteOnOrOff
    var kgOrLb = AppManager.sharedInstance.kgOrLb
    
    
    var timeBetweenSets = 120;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.value == 0
        {
            UserDefaults.standard.set(4, forKey: "setWaitTime")
            self.value == 4
            
            slider.value = Float(self.value)
            
            let currentTime = self.value*30
            
            let seconds = currentTime%60
            let minutes = (currentTime-seconds)/60
            
            timeLabel.text = "\(minutes) min \(seconds) sec"
        }
        else
        {
            slider.value = Float(self.value)
            
            let currentTime = self.value*30
            
            let seconds = currentTime%60
            let minutes = (currentTime-seconds)/60
            
            timeLabel.text = "\(minutes) min \(seconds) sec"
        }
        
        increaseLabel.value = Float(self.increase)
        timeLabel2.text = "+ \(increase) sec"
        
        let amountStored = UserDefaults.standard.integer(forKey: "amountCustomExercises")
        amountSlider.value = Float(amountStored)
        amountLabel.text = "\(amountStored)"
            
        if !mute
        {
            unmuteButton.backgroundColor = UIColor(white: 1, alpha: 1)
            unmuteButton.setTitleColor(UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1), for: UIControlState())
        }
        else
        {
            muteButton.backgroundColor = UIColor(white: 1, alpha: 1)
            muteButton.setTitleColor(UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1), for: UIControlState())
        }
        
        if !kgOrLb
        {
            kgUnitButton.backgroundColor = UIColor(white: 1, alpha: 1)
            kgUnitButton.setTitleColor(UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1), for: UIControlState())
        }
        else
        {
            lbUnitButton.backgroundColor = UIColor(white: 1, alpha: 1)
            lbUnitButton.setTitleColor(UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1), for: UIControlState())
        }
        
        let viewWidth: CGFloat = self.view.bounds.size.width
        self.changeTimeLabel.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        self.slider.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        self.timeLabel.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        self.sliderLabel.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        
        self.increaseTimeLabel.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        self.sliderLabel2.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        self.increaseLabel.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        self.timeLabel2.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        
        self.exerciseVoiceLabel.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        self.muteButton.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        self.unmuteButton.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        
        self.weightUnitsLabel.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        self.kgUnitButton.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        self.lbUnitButton.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        
        self.amountCustomExercises.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        self.sliderLabel3.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        self.amountLabel.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        self.amountSlider.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        
        self.rateButton.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        self.contactButton.transform = CGAffineTransform(translationX: viewWidth, y: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.changeTimeLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            
            self.sliderLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            self.slider.transform = CGAffineTransformMakeTranslation(0, 0);
            self.timeLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.increaseTimeLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            
            self.sliderLabel2.transform = CGAffineTransformMakeTranslation(0, 0);
            self.increaseLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            self.timeLabel2.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.exerciseVoiceLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            
            self.muteButton.transform = CGAffineTransformMakeTranslation(0, 0);
            self.unmuteButton.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.35, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.weightUnitsLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            
            self.kgUnitButton.transform = CGAffineTransformMakeTranslation(0, 0);
            self.lbUnitButton.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.40, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.amountCustomExercises.transform = CGAffineTransformMakeTranslation(0, 0);
            
            self.sliderLabel3.transform = CGAffineTransformMakeTranslation(0, 0);
            self.amountLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            self.amountSlider.transform = CGAffineTransformMakeTranslation(0, 0);
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.45, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.rateButton.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.50, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.contactButton.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderChanged(_ sender: AnyObject)
    {
        let currentValue = Int(self.slider.value)
        
        UserDefaults.standard.set(currentValue, forKey: "setWaitTime")
        
        let currentTime = currentValue*30
        
        let seconds = currentTime%60
        let minutes = (currentTime-seconds)/60
        
        timeLabel.text = "\(minutes) min \(seconds) sec"
    }
    
    @IBAction func increaseSliderChanged(_ sender: AnyObject)
    {
        let currentValue = Int(self.increaseLabel.value)
        
        UserDefaults.standard.set(currentValue, forKey: "exerciseWaitTime")
        
        timeLabel2.text = "+ \(currentValue) sec"
    }
    
    @IBAction func rateButtonPressed(_ sender: AnyObject)
    {
        let url = URL(string: "itms-apps://itunes.apple.com/app/bars/id979077719")
        if UIApplication.shared.canOpenURL(url!) == true
        {
            UIApplication.shared.openURL(url!)
        }
    }
    
    @IBAction func contactButtonPressed(_ sender: AnyObject)
    {
        
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setToRecipients(["tipsyelephantapps@gmail.com"])
        picker.setSubject("Mr Fit. Support")
        
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func muteButtonPressed(_ sender: AnyObject)
    {
        UserDefaults.standard.set(true, forKey: "muteOnOrOff")
        AppManager.sharedInstance.muteOnOrOff = true
        
        unmuteButton.backgroundColor = UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1)
        unmuteButton.setTitleColor(UIColor(white: 1, alpha: 1), for: UIControlState())
        muteButton.backgroundColor = UIColor(white: 1, alpha: 1)
        muteButton.setTitleColor(UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1), for: UIControlState())
    }
    
    @IBAction func unmuteButtonPressed(_ sender: AnyObject)
    {
        UserDefaults.standard.set(false, forKey: "muteOnOrOff")
        AppManager.sharedInstance.muteOnOrOff = false
        
        muteButton.backgroundColor = UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1)
        muteButton.setTitleColor(UIColor(white: 1, alpha: 1), for: UIControlState())
        unmuteButton.backgroundColor = UIColor(white: 1, alpha: 1)
        unmuteButton.setTitleColor(UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1), for: UIControlState())
    }
    
    @IBAction func kgUnitButtonPressed(_ sender: AnyObject)
    {
        UserDefaults.standard.set(false, forKey: "kgOrLb")
        AppManager.sharedInstance.kgOrLb = false
        
        lbUnitButton.backgroundColor = UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1)
        lbUnitButton.setTitleColor(UIColor(white: 1, alpha: 1), for: UIControlState())
        kgUnitButton.backgroundColor = UIColor(white: 1, alpha: 1)
        kgUnitButton.setTitleColor(UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1), for: UIControlState())
    }
    
    @IBAction func lbUnitButtonPressed(_ sender: AnyObject)
    {
        UserDefaults.standard.set(true, forKey: "kgOrLb")
        AppManager.sharedInstance.kgOrLb = true
        
        kgUnitButton.backgroundColor = UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1)
        kgUnitButton.setTitleColor(UIColor(white: 1, alpha: 1), for: UIControlState())
        lbUnitButton.backgroundColor = UIColor(white: 1, alpha: 1)
        lbUnitButton.setTitleColor(UIColor(red: 252/255, green: 162/255, blue: 101/255, alpha: 1), for: UIControlState())
    }
    
    @IBAction func amountSliderChanged(_ sender: AnyObject)
    {
        let currentValue = Int(self.amountSlider.value)
        UserDefaults.standard.set(currentValue, forKey: "amountCustomExercises")
        amountLabel.text = "\(currentValue)"
    }
    
    // MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController!, didFinishWith result: MFMailComposeResult, error: Error!) {
        dismiss(animated: true, completion: nil)
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
