//
//  BannerManager.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 4/15/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit
import iAd

class BannerManager: NSObject, ADBannerViewDelegate/*, ADInterstitialAdDelegate*/ {
   
    private static var __once: () = {
            Static.instance = BannerManager()
        }()
   
    class var sharedInstance: BannerManager {
        struct Static {
            static var instance: BannerManager?
            static var token: Int = 0
        }
        
        _ = BannerManager.__once
        
        return Static.instance!
    }
    
    var sharedBanner: ADBannerView = ADBannerView()
    var cargo = false
    
    func startBanner() {
        
        let SH = UIScreen.main.bounds.height
        self.sharedBanner.frame = CGRect(x: 0, y: SH, width: 0, height: 0)
        self.sharedBanner.delegate = self
        self.sharedBanner.alpha = 0
    }
    
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        UIView.animate(withDuration: 1, animations: {self.sharedBanner.alpha = 1})
        self.cargo = true
        println("CARGO BANNER (BannerMANAGER)")
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        UIView.animate(withDuration: 1, animations: {self.sharedBanner.alpha = 0})
        self.cargo = false
        println("NO CARGO BANNER (BannerMANAGER)")
    }
    
    
    /*var sharedIntAd: ADInterstitialAd = ADInterstitialAd()
    var cargoIntAd = false
    
    
    */
}
