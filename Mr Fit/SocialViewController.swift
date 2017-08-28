//
//  SocialViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 4/13/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class SocialViewController: UIViewController {

    @IBOutlet weak var facebookLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var facebookInfoLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        //self.view.backgroundColor = UIColor(red: 161/255, green: 214/255, blue: 255/255, alpha: 1)
        
        let viewWidth: CGFloat = self.view.bounds.size.width
        
        //self.facebookLabel.transform = CGAffineTransformMakeTranslation(viewWidth, 0)
        //self.facebookButton.transform = CGAffineTransformMakeTranslation(-viewWidth, 0)
        
        self.facebookLabel.alpha = 0
        self.facebookButton.alpha = 0
        self.facebookInfoLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            //self.facebookLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            self.facebookLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            //self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0);
            self.facebookButton.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.facebookInfoLabel.alpha = 1
            }, completion: nil)
    }
    
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
    
    @IBAction func facebookButtonPressed(_ sender: AnyObject)
    {
        let permissions = ["public_profile","email","user_friends"]       
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions, block: {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                } else {
                    println("User logged in through Facebook!")
                }
                AppManager.sharedInstance.obtainUserNameAndFbId()
                
                let currentUser = PFUser.currentUser()
                if let userScore = currentUser?["Score"] as? Int
                {
                    if userScore<AppManager.sharedInstance.workoutScore
                    {
                        currentUser?["Score"] = AppManager.sharedInstance.workoutScore
                        currentUser?.saveEventually()
                    }
                }
                
                self.performSegueWithIdentifier("goToLeaderboard",sender:self)
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        })
    }
    
    @IBAction func returnSocial(_ segue:UIStoryboardSegue)
    {
        println("se devolvio")
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
