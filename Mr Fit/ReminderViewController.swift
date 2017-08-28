//
//  ReminderViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/22/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var turnOffButton: UIButton!
    @IBOutlet weak var turnOnButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        
        if AppManager.sharedInstance.remindersOnOrOff == 0
        {
            self.titleLabel.text = "Reminders - OFF"
        }
        else
        {
            self.titleLabel.text = "Reminders - ON"
        }
        
        self.slider.value = Float(AppManager.sharedInstance.remindersOnOrOff)
        self.assignText()
        
        let viewHeight: CGFloat = self.view.bounds.size.height
        
        self.titleLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.sentenceLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.timeLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.sliderLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.slider.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.turnOffButton.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.turnOnButton.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animateWithDuration(1.1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(1.1, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.sentenceLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(1.1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.timeLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(1.1, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.sliderLabel.transform = CGAffineTransformMakeTranslation(0, 0)
            self.slider.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        UIView.animateWithDuration(1.1, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.turnOffButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(1.1, delay: 0.35, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.turnOnButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if !(UIApplication.shared.isRegisteredForRemoteNotifications)
        {
            var alert = UIAlertController(title: "User Notifications", message:"Please enable Notifications for the Reminders to work! You can enable notifications for Mr. Fit by going to the settings app." , preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                action in
                switch action.style{
                case .default:
                    let userNotificationTypes = (UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound)
                    let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
                    UIApplication .sharedApplication().registerUserNotificationSettings(settings)
                    UIApplication.shared.registerForRemoteNotifications()
                case .cancel:
                    println("canceled")
                case .destructive:
                    println("destructive")
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func assignText()
    {
        let reminderOnOrOff = AppManager.sharedInstance.remindersOnOrOff
        
        if reminderOnOrOff == 1
        {
            self.timeLabel.text = "One Day"
        }
        else if reminderOnOrOff == 2
        {
            self.timeLabel.text = "Two Days"
        }
        else if reminderOnOrOff == 3
        {
            self.timeLabel.text = "Three Days"
        }
        else if reminderOnOrOff == 4
        {
            self.timeLabel.text = "Four Days"
        }
        else if reminderOnOrOff == 5
        {
            self.timeLabel.text = "Five Days"
        }
        else if reminderOnOrOff == 6
        {
            self.timeLabel.text = "Six Days"
        }
        else if reminderOnOrOff == 7
        {
            self.timeLabel.text = "One Week"
        }
        else if reminderOnOrOff == 8
        {
            self.timeLabel.text = "Two Weeks"
        }
    }
    
    @IBAction func sliderChanged(_ sender: AnyObject)
    {
        AppManager.sharedInstance.remindersOnOrOff = Int(self.slider.value)
        self.assignText()
        self.titleLabel.text = "Reminders - ON"
        UserDefaults.standard.set(Int(self.slider.value), forKey: "reminderOnOrOff")
    }
    
    @IBAction func turnOnButtonPressed(_ sender: AnyObject)
    {
        AppManager.sharedInstance.remindersOnOrOff = Int(self.slider.value)
        self.titleLabel.text = "Reminders - ON"
        UserDefaults.standard.set(Int(self.slider.value), forKey: "reminderOnOrOff")
    }
    
    @IBAction func turnOffButtonPressed(_ sender: AnyObject)
    {
        self.titleLabel.text = "Reminders - OFF"
        AppManager.sharedInstance.remindersOnOrOff = 0
        UserDefaults.standard.set(0, forKey: "reminderOnOrOff")
    }
    
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
