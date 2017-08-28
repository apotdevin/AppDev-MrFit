//
//  CustomWorkoutViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 6/1/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class CustomWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var setsButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var exercises: [String] = []
    var times: [Int] = []
    var waits: [Int] = []
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.titleLabel.alpha = 0
        self.addButton.alpha = 0
        self.deleteButton.alpha = 0
        self.table.alpha = 0
        self.setsButton.alpha = 0
        self.startButton.alpha = 0
        
        table.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        UIView.animate(withDuration: 0.7, delay: 0.05, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.titleLabel.alpha = 1
            self.addButton.alpha = 1
            self.deleteButton.alpha = 1
            }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.15, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.table.alpha = 1
            }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.25, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.setsButton.alpha = 1
            self.startButton.alpha = 1
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
        //return exerciseList.count
        return AppManager.sharedInstance.customWorkoutExercises.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomWorkoutCell", for: indexPath) as! CustomWorkoutCell
        
        cell.exerciseButton.tag = indexPath.row
        cell.exerciseTitleLabel.tag = indexPath.row
        cell.exerciseImageView.tag = indexPath.row
        cell.exerciseTimeLabel.tag = indexPath.row
        cell.exerciseTimeSlider.tag = indexPath.row
        cell.waitTimeLabel.tag = indexPath.row
        cell.waitTimeSlider.tag = indexPath.row
        
        cell.exerciseButton.setTitle("\(indexPath.row+1). Which Exercise? >", for: UIControlState())
        cell.exerciseTitleLabel.text = AppManager.sharedInstance.customWorkoutExercises[indexPath.row]
        cell.exerciseImageView.image = UIImage(named: AppManager.sharedInstance.customWorkoutExercises[indexPath.row])
        cell.exerciseTimeLabel.text = " Exercise Time: \(AppManager.sharedInstance.customWorkoutTimes[indexPath.row]) sec"
        cell.exerciseTimeSlider.value = Float(AppManager.sharedInstance.customWorkoutTimes[indexPath.row])
        cell.waitTimeLabel.text = " Wait Time: \(AppManager.sharedInstance.customWorkoutWait[indexPath.row]) sec"
        cell.waitTimeSlider.value = Float(AppManager.sharedInstance.customWorkoutWait[indexPath.row])
        
        return cell
    }
    
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // MARK: - Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AppManager.sharedInstance.cualExercise.sets.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(AppManager.sharedInstance.cualExercise.sets[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.alpha = 0
        table.alpha = 1
        setsButton.isEnabled = true
        startButton.isEnabled = true
        addButton.isEnabled = true
        deleteButton.isEnabled = true
        
        AppManager.sharedInstance.cualExercise.currentSets = AppManager.sharedInstance.cualExercise.sets[row]
        setsButton.setTitle("SETS: \(AppManager.sharedInstance.cualExercise.currentSets)", for: UIControlState())
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        let titleData = "\(AppManager.sharedInstance.cualExercise.sets[row])"
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName: UIFont(name: "Oswald", size:25)!,NSForegroundColorAttributeName:UIColor.black])
        pickerLabel.attributedText = myTitle
        
        pickerLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    //---------------------------------------------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButtonPressed(_ sender: AnyObject)
    {
        AppManager.sharedInstance.customWorkoutExercises.append("Jumping Jacks")
        AppManager.sharedInstance.customWorkoutTimes.append(30)
        AppManager.sharedInstance.customWorkoutWait.append(5)
        
        table.reloadData()
    }
    
    @IBAction func deleteButtonPressed(_ sender: AnyObject)
    {
        if AppManager.sharedInstance.customWorkoutExercises.count>1
        {
            AppManager.sharedInstance.customWorkoutExercises.removeLast()
            AppManager.sharedInstance.customWorkoutTimes.removeLast()
            AppManager.sharedInstance.customWorkoutWait.removeLast()
            
            table.reloadData()
        }
    }
    
    @IBAction func setsButtonPressed(_ sender: AnyObject)
    {
        table.alpha = 0
        setsButton.isEnabled = false
        startButton.isEnabled = false
        picker.alpha = 1
        addButton.isEnabled = false
        deleteButton.isEnabled = false
    }
    
    @IBAction func startButtonPressed(_ sender: AnyObject)
    {
        if AppManager.sharedInstance.customWorkoutExercises.count>0
        {
            AppManager.sharedInstance.customOrNot = 2
            UIApplication.shared.isIdleTimerDisabled = true
            
            AppManager.sharedInstance.custom.exercises = AppManager.sharedInstance.customWorkoutExercises
            AppManager.sharedInstance.custom.exerciseTimes = AppManager.sharedInstance.customWorkoutTimes
            AppManager.sharedInstance.custom.waitTimes = AppManager.sharedInstance.customWorkoutWait
        }
    }
    
    @IBAction func cancelCustomWorkout(_ segue:UIStoryboardSegue)
    {
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
