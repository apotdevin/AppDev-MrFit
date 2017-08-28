//
//  MenuViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 3/23/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        table.reloadData()
        
        let background = UIImageView(image: UIImage(named: "menuBackground"))
        table.backgroundView = background
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return AppManager.sharedInstance.menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! titleCell
        cell.backgroundColor = UIColor.clear
        
        if AppManager.sharedInstance.menuItems[indexPath.row] == ">>>WORKOUTS"
        {
            cell.titleLabel.text = AppManager.sharedInstance.menuItems[indexPath.row]
            //cell.titleLabel.textColor = UIColor.blackColor()
            
            cell.isUserInteractionEnabled = false
            
        }
        else if AppManager.sharedInstance.menuItems[indexPath.row] == ">>>SCORE"
        {
            cell.titleLabel.text = "\(AppManager.sharedInstance.menuItems[indexPath.row]) = \(AppManager.sharedInstance.workoutScore)xp"
            //cell.titleLabel.textColor = UIColor.blackColor()
            
            cell.isUserInteractionEnabled = false
        }
        else
        {
            var cellText = AppManager.sharedInstance.menuItems[indexPath.row]
            if AppManager.sharedInstance.banner != 718
            {
                if cellText == "> In a Hurry Abs" || cellText == "> Need Legs?" || cellText == "> The Soldier" || cellText == "> The Samurai" || cellText == "> Full Fit" || cellText == "> Random" || cellText == "> Custom" || cellText == "> Advanced 7 Minute" || cellText == "> Daily Quickie"
                {
                    cellText = "\(AppManager.sharedInstance.menuItems[indexPath.row]) (L)"
                }
            }
            cell.titleLabel.text = cellText
            cell.isUserInteractionEnabled = true
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let amountExercises = AppManager.sharedInstance.amount
        
        if indexPath.row == 2
        {
            AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.original
            AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset1
            
            self.performSegue(withIdentifier: "goToExercise",sender:self)
        }
        else if indexPath.row == 3
        {
            AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.advanced
            AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset7
            
            self.performSegue(withIdentifier: "goToExercise",sender:self)
        }
        else if indexPath.row == 4
        {
            AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.steelAbs
            AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset2
            
            self.performSegue(withIdentifier: "goToExercise",sender:self)
        }
        else if indexPath.row == 5
        {
            AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.batman
            AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset4
            
            self.performSegue(withIdentifier: "goToExercise",sender:self)
        }
        else if indexPath.row == 6
        {
            if AppManager.sharedInstance.banner == 718
            {
                AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.twoMinAbs
                AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset3
                
                self.performSegue(withIdentifier: "goToExercise",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 7
        {
            if AppManager.sharedInstance.banner == 718
            {
                AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.legDay
                AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset5
                
                self.performSegue(withIdentifier: "goToExercise",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 8
        {
            if AppManager.sharedInstance.banner == 718
            {
                AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.navySeal
                AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset6
                
                self.performSegue(withIdentifier: "goToExercise",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 9
        {
            if AppManager.sharedInstance.banner == 718
            {
                AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.ninja
                AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset7
                
                self.performSegue(withIdentifier: "goToExercise",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 10
        {
            if AppManager.sharedInstance.banner == 718
            {
                AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.aquaman
                AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset8
                
                self.performSegue(withIdentifier: "goToExercise",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 11
        {
            if AppManager.sharedInstance.banner == 718
            {
                AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.quickie
                AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset4
                
                self.performSegue(withIdentifier: "goToExercise",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 12
        {
            if AppManager.sharedInstance.banner == 718
            {
                AppManager.sharedInstance.randomize()
                
                AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.random
                AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.randomPreset
                
                self.performSegue(withIdentifier: "goToExercise",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 13
        {
            if AppManager.sharedInstance.banner == 718
            {
                AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.custom
                AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset3
                
                self.performSegue(withIdentifier: "goToCustomWorkout",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
