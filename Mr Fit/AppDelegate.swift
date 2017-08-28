//
//  AppDelegate.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 3/23/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit
import iAd
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    //var UIiAd: ADBannerView = ADBannerView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId("vpg6zk0xwe6JC7SVxWklBBxUjiAyX4EjmV54YWca", clientKey: "FCNCGe2BV997bK1uivUKLx2XmFoELDXNOC6YReyl")
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        if let launchOptions = launchOptions {
            PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        } else {
            PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions([AnyHashable: Any]())
        }
        
        PFPurchase.addObserverForProduct("mrfit.ultimate", block: { (transaction:SKPaymentTransaction!) -> Void in
            PFPurchase.downloadAssetForTransaction(transaction, completion: { (filePath:String!, error:NSError!) -> Void in
                if (error != nil)
                {
                    println("Error de compra")
                }
                else
                {
                    println("compradooo")
                    
                    NSUserDefaults.standardUserDefaults().setSecretInteger(718, forKey: "EraseAppData")
                    AppManager.sharedInstance.banner = 718
                    
                    let sharedDefaults = NSUserDefaults(suiteName: "group.com.MrFit.shared")
                    sharedDefaults?.setInteger(5201, forKey: "ArmInfo")
                }
            })
        })
        
        var audioSessionError: NSError?
        if AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient, error: &audioSessionError)
        {
            println("Changed audio session")
        }
        else
        {
            println("Did not change")
        }
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        //NSUserDefaults.setSecret("This app is Mr. Fit!")
        UserDefaults.standard.setSecret("This app is Mr. Fit!")
        
        AppManager.sharedInstance.start()
        BannerManager.sharedInstance.startBanner()
        
        AppManager.sharedInstance.obtainUserNameAndFbId()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        UserDefaults.standard.set(AppManager.sharedInstance.customWorkoutTimes, forKey: "customWorkoutTimes")
        UserDefaults.standard.set(AppManager.sharedInstance.customWorkoutWait, forKey: "customWorkoutWait")
        UserDefaults.standard.set(AppManager.sharedInstance.customWorkoutExercises, forKey: "customWorkoutExercises")
        
        UserDefaults.standard.synchronize()
        self.setReminders()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
        self.deleteReminders()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        UserDefaults.standard.synchronize()
    }
    
    func application(_ application: UIApplication,
        open url: URL,
        sourceApplication: String?,
        annotation: Any) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackground()
    }
    
    func deleteReminders()
    {
        UIApplication.shared.cancelAllLocalNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        println("reminders DELETED")
    }
    
    func setReminders()
    {
        let whatReminder = AppManager.sharedInstance.remindersOnOrOff
        
        if whatReminder != 0
        {
            var localNotification = UILocalNotification()
            localNotification.timeZone = TimeZone.current
            
            var days = 0
            var text = ""
            
            if whatReminder == 1
            {
                days = 1
                text = "One day has passed! Let's workout with Mr. Fit!"
            }
            else if whatReminder == 2
            {
                days = 2
                text = "Two days have passed! Let's workout with Mr. Fit!"
            }
            else if whatReminder == 3
            {
                days = 3
                text = "Three days have passed! Let's workout with Mr. Fit!"
            }
            else if whatReminder == 4
            {
                days = 4
                text = "Four days have passed! Let's workout with Mr. Fit!"
            }
            else if whatReminder == 5
            {
                days = 5
                text = "Five days have passed! Let's workout with Mr. Fit!"
            }
            else if whatReminder == 6
            {
                days = 6
                text = "Six days have passed! Let's workout with Mr. Fit!"
            }
            else if whatReminder == 7
            {
                days = 7
                text = "One week has passed! Let's workout with Mr. Fit!"
            }
            else if whatReminder == 8
            {
                days = 14
                text = "Two weeks have passed! Let's workout with Mr. Fit!"
            }
            
            localNotification.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + days
            localNotification.fireDate = Date(timeIntervalSinceNow: TimeInterval(60*60*24*days))
            localNotification.alertBody = text
            
            UIApplication.shared.scheduleLocalNotification(localNotification)
            
            println("reminders SET")
        }
    }
    
}

