//
//  RightMenuViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 4/22/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class RightMenuViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    var tableIndex = 0
    var tableList = [""]
    
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
        
        if AppManager.sharedInstance.banner == 718
        {
            tableList = AppManager.sharedInstance.otherItemsBought
            tableIndex = 1
        }
        else
        {
            tableList = AppManager.sharedInstance.otherItems
            tableIndex = 0
        }
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
        
        return tableList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! titleCell
        cell.backgroundColor = UIColor.clear
        
        if AppManager.sharedInstance.otherItems[indexPath.row] == ">>>OTHER"
        {
            cell.titleLabel.text = AppManager.sharedInstance.otherItems[indexPath.row]
            //cell.titleLabel.textColor = UIColor.blackColor()
            cell.isUserInteractionEnabled = false
        }
        else
        {//[">>>OTHER","> Ultimate Purchase","> Social","> Custom Timer","> Exercise Log","> Weight Log","> Reminders","> Settings"]
            var cellText = tableList[indexPath.row]
            if AppManager.sharedInstance.banner != 718
            {
                if cellText == "> Custom Timer" || cellText == "> Weight Log" || cellText == "> Reminders"
                {
                    cellText = "\(tableList[indexPath.row]) (L)"
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
            
        if indexPath.row == 1 && tableIndex == 0
        {
            self.performSegue(withIdentifier: "goToPurchase",sender:self)
        }
        else if indexPath.row == 2 - tableIndex
        {
            var currentUser = PFUser.currentUser()
            if currentUser != nil {
                self.performSegue(withIdentifier: "goToLeaderboard",sender:self)
            } else {
                self.performSegue(withIdentifier: "goToSocial",sender:self)
            }
        }
        else if indexPath.row == 3 - tableIndex
        {
            if AppManager.sharedInstance.banner == 718
            {
                self.performSegue(withIdentifier: "goToCustom",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
            
        }
        else if indexPath.row == 4 - tableIndex
        {
            self.performSegue(withIdentifier: "showGraph",sender:self)
        }
        else if indexPath.row == 5 - tableIndex
        {
            if AppManager.sharedInstance.banner == 718
            {
                self.performSegue(withIdentifier: "showGraph2",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 6 - tableIndex
        {
            if AppManager.sharedInstance.banner == 718
            {
                self.performSegue(withIdentifier: "goToReminder",sender:self)
            }
            else
            {
                self.performSegue(withIdentifier: "goToPurchase",sender:self)
            }
        }
        else if indexPath.row == 7 - tableIndex
        {
            self.performSegue(withIdentifier: "goToSettings",sender:self)
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
