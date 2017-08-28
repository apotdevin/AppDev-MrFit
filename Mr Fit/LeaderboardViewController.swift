//
//  LeaderboardViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/16/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var loggedOutLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var friendList = [""]
    var friendData = [NSDictionary]()
    var friendId:Array<AnyObject> = []
    //var friendScore:Array<AnyObject> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let viewHeight: CGFloat = self.view.bounds.size.height
        
        self.titleLabel.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.table.transform = CGAffineTransform(translationX: 0, y: viewHeight)
        self.logOutButton.alpha = 0
        
        
        if (AppManager.sharedInstance.leaderboardFriends.firstObject != nil)
        {
            self.friendData = AppManager.sharedInstance.leaderboardFriends as! [(NSDictionary)]
            self.table.reloadData()
        }
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            FBSDKGraphRequest(graphPath: "/me/friends", parameters: nil).startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                if (error == nil)
                {
                    self.friendData = []
                    
                    //Agregar al usuario-----------------------
                    if let user2 = PFUser.currentUser()
                    {
                        var nameUser = ""
                        var scoreUser = 0
                        var idUser = ""
                        
                        if let userScore = user2["Score"] as? NSNumber
                        {
                            scoreUser = userScore.integerValue
                        }
                        if let userName = user2["username"] as? NSString
                        {
                            nameUser = userName as String
                        }
                        if let userId = user2["fbId"] as? String
                        {
                            idUser = userId as String
                        }
                        
                        let oneFriend = ["Name":nameUser,"Score":scoreUser,"fbId":idUser]
                        
                        self.friendData.append(oneFriend)
                        
                        println("Agrego Usuario")
                    }
                    
                    //Agregar a los amigos----------------------
                    
                    let results = result as? NSDictionary
                    
                    if (results != nil)
                    {
                        if let list = results?.objectForKey("data") as? NSArray
                        {
                            let total = list.count
                            for var index = 0; index<total; ++index
                            {
                                if let user = list[index] as? NSDictionary
                                {
                                    var userId = ""
                                    
                                    if let id = user.objectForKey("id") as? NSString
                                    {
                                        userId = id as String
                                        //println(id)
                                    }
                                    
                                    self.friendId.append(userId)
                                    
                                }
                            }
                        }
                    }
                    
                    //println(self.friendId)
                    
                    let friendQuery = PFUser.query()?.whereKey("fbId", containedIn: self.friendId)
                    let friendObjects: Array<AnyObject>! = friendQuery?.findObjects()
                    
                    //println(friendObjects)
                    
                    let amountOfFriends = friendObjects?.count
                    
                    for var index = 0; index<amountOfFriends; ++index
                    {
                        let user:PFUser = friendObjects[index] as! PFUser
                        
                        var nameUser = ""
                        var scoreUser = 0
                        var idUser = ""
                        
                        if let userScore = user["Score"] as? NSNumber
                        {
                            scoreUser = userScore.integerValue
                        }
                        if let userName = user["username"] as? NSString
                        {
                            nameUser = userName as String
                        }
                        if let userId = user["fbId"] as? String
                        {
                            idUser = userId as String
                        }
                        let oneFriend = ["Name":nameUser,"Score":scoreUser,"fbId":idUser]
                        
                        self.friendData.append(oneFriend)
                    }
                    println("Agrego Amigos")
                    
                    /*
                    NSSortDescriptor *xpDescriptor = [[NSSortDescriptor alloc] initWithKey:@"Xp" ascending:NO];
                    NSArray *sortDescriptors = @[xpDescriptor];
                    sortedArray = [friends sortedArrayUsingDescriptors:sortDescriptors];
                    */
                    
                    //let xpDescriptor = NSSortDescriptor(key: "Score", ascending: false)
                    //var asdasd: Array = self.friendData.s
                    
                    //let sortDescriptors = [xpDescriptor]
                    
                    AppManager.sharedInstance.leaderboardFriends = self.friendData
                    
                    UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
                        self.table.alpha = 0
                        }, completion: nil)
                    UIView.animateWithDuration(1, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
                        self.table.alpha = 1
                        }, completion: nil)
                    
                    self.table.reloadData()
                    
                }
                else
                {
                    println("\(error.localizedDescription)")
                }
            })
        }
        
        self.loggedOutLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animateWithDuration(1.3, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(1.3, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.table.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        UIView.animateWithDuration(2, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.logOutButton.alpha = 1
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButton(_ sender: AnyObject)
    {
        self.logOutButton.isEnabled = false
        PFUser.logOut()
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.loggedOutLabel.alpha = 0.9
            }, completion: nil)
    }
    
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.friendData.count
    }
    
    /*func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad
        {
            return 100
        }
        else
        {
            return 70
        }
    }*/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderCell", for: indexPath) as! LeaderboardCell
        
        cell.backgroundColor = UIColor.clear
        cell.isUserInteractionEnabled = false
        
        let user:NSDictionary = self.friendData[indexPath.row]
        
        let name = user["Name"] as! String
        var score = user["Score"] as! Int
        let id = user["fbId"] as! String
        
        cell.nameLabel.text = "\(name)"
        cell.scoreLabel.text = "Score: \(score)xp"
        cell.profilePicture.profileID = "\(id)"
        
        return cell
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
