//
//  PauseViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 3/30/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class PauseViewController: UIViewController {

    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        let viewWidth: CGFloat = self.view.bounds.size.width
        let viewHeight: CGFloat = self.view.bounds.size.height
        
        self.resumeButton.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.skipButton.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.quitButton.transform = CGAffineTransform(translationX: 0, y: viewHeight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.resumeButton.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.skipButton.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.quitButton.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject)
    {
        var alert = UIAlertController(title: "You will lose your current progress!", message:"Are you sure?" , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "I'm done", style: .default, handler: {
            action in
            switch action.style{
            case .default:
                if AppManager.sharedInstance.customOrNot == 1
                {
                    UIApplication.shared.isIdleTimerDisabled = false
                    self.performSegue(withIdentifier: "cancelWorkoutSegue",sender:self)
                }
                else
                {
                    UIApplication.shared.isIdleTimerDisabled = false
                    self.performSegue(withIdentifier: "cancelCustomWorkoutSegue",sender:self)
                }
            case .cancel:
                println("canceled")
            case .destructive:
                println("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "I can go on!", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func resumeButtonPressed(_ sender: AnyObject) {
        println("resume")
        AppManager.sharedInstance.skip = false
        
        self.performSegue(withIdentifier: "resumeWorkoutSegue", sender: self)
        
    }
    @IBAction func skipButtonPressed(_ sender: AnyObject)
    {
        println("skip")
        AppManager.sharedInstance.skip = true
        
        self.performSegue(withIdentifier: "resumeWorkoutSegue", sender: self)
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
