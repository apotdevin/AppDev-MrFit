//
//  PhraseViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 4/12/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class PhraseViewController: UIViewController {
    
    @IBOutlet weak var phraseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {
        
        AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.original
        AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset1
        
        self.performSegue(withIdentifier: "goTo",sender:self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let cantidadPhrases = UInt32(AppManager.sharedInstance.phrases.count)
        let cual = Int(arc4random_uniform(cantidadPhrases))
        
        self.phraseLabel.text = AppManager.sharedInstance.phrases[cual]
        
        self.phraseLabel.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1, delay: 0.2, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.phraseLabel.alpha = 1.0
            }, completion: nil)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
