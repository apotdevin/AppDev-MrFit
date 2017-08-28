//
//  PurchaseViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 4/15/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit
import StoreKit

class PurchaseViewController: UIViewController, SKProductsRequestDelegate {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var buttonBackgroundLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var restoreButton: UIButton!
    
    var productIDs: Array<String?> = []
    var productsArray: Array<SKProduct?> = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.textLabel.text = " The ultimate purchase will give you everything! \n\n -It will remove all in app advertising!\n -It will give you 5 more workouts!\n -You can do a random workout!\n -You can make a custom workout!\n -It will allow you to set workout reminders!\n -It will give you all future workouts that are added!\n -It will let you track your weight progress!\n -Unlock the same 5 workouts on the Apple Watch!\n -Unlock the custom timer on the Apple Watch!\n\n 5 Included Workouts:\n > In a Hurry Abs.\n > Need Legs?\n > The Soldier\n > The Samurai\n > Full Fit.\n\n MORE to come!"
        
        productIDs.append("mrfit.ultimate")
        requestProductInfo()
        
        let purchased = AppManager.sharedInstance.banner
        if purchased == 718
        {
            buyButton.isEnabled = false
            buyButton.setTitle("Purchased!", for: UIControlState())
        }
        
        let viewWidth: CGFloat = self.view.bounds.size.height
        topLabel.transform = CGAffineTransform(translationX: 0, y: viewWidth)
        secondLabel.transform = CGAffineTransform(translationX: 0, y: viewWidth)
        textLabel.transform = CGAffineTransform(translationX: 0, y: viewWidth)
        buttonBackgroundLabel.transform = CGAffineTransform(translationX: 0, y: viewWidth)
        buyButton.transform = CGAffineTransform(translationX: 0, y: viewWidth)
        restoreButton.transform = CGAffineTransform(translationX: 0, y: viewWidth)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.topLabel.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.secondLabel.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.textLabel.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        UIView.animateWithDuration(1.5, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.buttonBackgroundLabel.transform = CGAffineTransformMakeTranslation(0, 0);
            self.buyButton.transform = CGAffineTransformMakeTranslation(0, 0);
            self.restoreButton.transform = CGAffineTransformMakeTranslation(0, 0);
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
    
    @IBAction func buyButtonPressed(_ sender: AnyObject)
    {
        PFPurchase.buyProduct("mrfit.ultimate", block: { (error:NSError!) -> Void in
            if (error != nil)
            {
                var alert = UIAlertController(title: "Something went wrong!", message: "Please try to purchase again.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else
            {
                var alert = UIAlertController(title: "Purchased!", message: "Thanks for your purchase!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Let's workout!", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                self.buyButton.enabled = false
                self.buyButton.setTitle("Purchased!", forState: UIControlState.Normal)
            }
        })
    }
    
    @IBAction func restoreButtonPressed(_ sender: AnyObject)
    {
        PFPurchase.restore()
        
        restoreButton.isEnabled = false
        buyButton.isEnabled = false
    }
    
    func productsRequest(_ request: SKProductsRequest!, didReceive response: SKProductsResponse!) {
        if response.products.count != 0
        {
            for product in response.products
            {
                productsArray.append(product )
            }
            if productsArray.count>0
            {
                let product = productsArray[0]
                
                let formatter = NumberFormatter()
                formatter.numberStyle = .currency
                formatter.locale = product?.priceLocale
                
                let formattedString: String! = formatter.string(from: product!.price)
                self.buyButton.setTitle("\(formattedString) >", for: UIControlState())
                //println(formattedString)
            }
            
            let purchased = AppManager.sharedInstance.banner
            if purchased == 718
            {
                buyButton.isEnabled = false
                buyButton.setTitle("Purchased!", for: UIControlState())
            }
        }
        else
        {
            println("There are no products.")
        }
        if response.invalidProductIdentifiers.count != 0
        {
            println(response.invalidProductIdentifiers.description)
        }
    }
    
    func requestProductInfo()
    {
        if SKPaymentQueue.canMakePayments()
        {
            let productIdentifiers = NSSet(array: productIDs)
            let productRequest = SKProductsRequest(productIdentifiers: (((((((productIdentifiers as Set<NSObject>) as Set<NSObject>) as Set<NSObject>) as Set<NSObject>) as Set<NSObject>) as Set<NSObject>) as Set<NSObject>) as Set<NSObject>)
            
            productRequest.delegate = self
            productRequest.start()
        }
        else
        {
            println("Cannot perform In App Purchases.")
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
    
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
