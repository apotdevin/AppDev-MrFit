//
//  FinishedViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 3/29/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit
import AVFoundation
import Social

class FinishedViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var goodJobLabel: UILabel!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var earnedLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var returnLabel: UILabel!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var rate: Float = 0.2
    var pitchMultiplier: Float = 1.0
    var volume: Float = 1.0
    
    let mute = UserDefaults.standard.bool(forKey: "muteOnOrOff")
    
    var imagePicker: UIImagePickerController!
    var finalImage = UIImage()
    var whichView = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        UIApplication.shared.isIdleTimerDisabled = false
        
        completedLabel.text = " Completed: \(AppManager.sharedInstance.cualExercise.name)"
        earnedLabel.text = " Earned: \(AppManager.sharedInstance.earnedScore)xp"
        totalLabel.text = " Total: \(AppManager.sharedInstance.workoutScore)xp"
        AppManager.sharedInstance.earnedScore = 0
        
        if mute
        {
            volume = 0.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*let speechUtterance = AVSpeechUtterance(string: "Good job. You finished your workout!")
        speechUtterance.rate = rate
        speechUtterance.pitchMultiplier = pitchMultiplier
        speechUtterance.volume = volume
        speechSynthesizer.speakUtterance(speechUtterance)*/
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func facebookButtonPressed(_ sender: AnyObject) {
        
        whichView = 1
        
        var alert = UIAlertController(title: nil, message:"Use photo from:" , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            switch action.style{
            case .default:
                self.presentCamera()
            case .cancel:
                println("canceled")
            case .destructive:
                println("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            switch action.style{
            case .default:
                self.presentLibrary()
            case .cancel:
                println("canceled")
            case .destructive:
                println("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
        /*
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            var facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            //facebookSheet.setInitialText("I just finished the ''\(AppManager.sharedInstance.cualExercise.name)'' workout with Mr. Fit!")
            facebookSheet.setInitialText("asdadadad")
            facebookSheet.addImage(UIImage(named: "Jumping Jacks.png"))
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }*/
    }
    @IBAction func twitterButtonPressed(_ sender: AnyObject) {
        
        whichView = 2
        
        var alert = UIAlertController(title: nil, message:"Use photo from:" , preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            switch action.style{
            case .default:
                self.presentCamera()
            case .cancel:
                println("canceled")
            case .destructive:
                println("destructive")
            }
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            switch action.style{
            case .default:
                self.presentLibrary()
            case .cancel:
                println("canceled")
            case .destructive:
                println("destructive")
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
        /*
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            var twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("I just finished the ''\(AppManager.sharedInstance.cualExercise.name)'' workout with Mr. Fit!")
            twitterSheet.addImage(UIImage(named: "Jumping Jacks"))
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }*/
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        imagePicker.dismiss(animated: true, completion: nil)
        
        if whichView == 1
        {
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                //facebookSheet.setInitialText("I just finished the ''\(AppManager.sharedInstance.cualExercise.name)'' workout with Mr. Fit!")
                facebookSheet.add(self.textToImage("Working out with Mr Fit!", inImage: image, atPoint: CGPoint(x: 20, y: image.size.height-80)))
                self.present(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else if whichView == 2
        {
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
                let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterSheet.setInitialText("I just finished the ''\(AppManager.sharedInstance.cualExercise.name)'' workout with Mr. Fit!")
                twitterSheet.add(self.textToImage("Working out with Mr Fit!", inImage: image, atPoint: CGPoint(x: 20, y: image.size.height-80)))
                self.present(twitterSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        whichView = 0
    }
    
    func presentCamera()
    {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "No Camera", message: "Please allow this app the use of your camera in settings.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func presentLibrary()
    {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary))
        {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            
            present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "No Photo Library", message: "Please allow this app the use of your photo library in settings.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func textToImage(_ drawText: NSString, inImage: UIImage, atPoint: CGPoint)->UIImage
    {
        let textColor:UIColor = UIColor.white
        let textFont:UIFont = UIFont(name: "Oswald-Bold", size: 60)!
        
        UIGraphicsBeginImageContext(inImage.size)
        
        let textFontAttributes = [NSFontAttributeName: textFont, NSForegroundColorAttributeName: textColor,] as [String : Any]
        inImage.draw(in: CGRect(x: 0, y: 0, width: inImage.size.width, height: inImage.size.height))
        
        let rect: CGRect = CGRect(x: atPoint.x, y: atPoint.y, width: inImage.size.width, height: inImage.size.height)
        drawText.draw(in: rect, withAttributes: textFontAttributes)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    @IBAction func homeButtonPressed(_ sender: AnyObject)
    {
        if AppManager.sharedInstance.customOrNot == 1
        {
            self.performSegue(withIdentifier: "cancelWorkout",sender:self)
        }
        else
        {
            self.performSegue(withIdentifier: "cancelCustomWorkout",sender:self)
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
}
