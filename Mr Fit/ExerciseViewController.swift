//
//  ExerciseViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 3/23/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit
import AVFoundation

class ExerciseViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var exerciseTitle: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var setsButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    
    var exerciseList: [String] = []
    var currentColors = PresetColor()
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var rate: Float = 0.15
    var pitchMultiplier: Float = 1.0
    var volume: Float = 1.0
    
    let mute = UserDefaults.standard.bool(forKey: "muteOnOrOff")
    
    var isIpad:Bool = false
    
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    override func viewWillAppear(_ animated: Bool) {
        
        if mute
        {
            volume = 0.0
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            isIpad = true
        }
        
        super.viewWillAppear(animated)
        self.exerciseTitle.alpha = 0.0
        self.time.alpha = 0.0
        self.startButton.alpha = 0.0
        self.setsButton.alpha = 0.0
        self.infoButton.alpha = 0.0
        
        animateTable()
        
        table.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
    }
    
    func animateTable()
    {
        table.reloadData()
        
        let cells = table.visibleCells
        let tableHeight: CGFloat = table.bounds.size.height
        let viewWidth: CGFloat = self.view.bounds.size.width
        
        var whichOne: (Float) = 1
        
        var randomAnim = arc4random_uniform(5)
        
        if self.isIpad
        {
            randomAnim = 5
        }
        
        if randomAnim == 0
        {
            for i in cells
            {
                let cell: exerciseCell = i as! exerciseCell
                
                var what = whichOne % 2
                
                if  what != 0
                {
                    cell.transform = CGAffineTransform(translationX: viewWidth, y: 0)
                }
                else
                {
                    cell.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
                }
                
                whichOne += 1
            }
        }
        else if randomAnim == 1
        {
            for i in cells
            {
                let cell: exerciseCell = i as! exerciseCell
                cell.transform = CGAffineTransform(translationX: viewWidth, y: 0)
            }
        }
        else if randomAnim == 2
        {
            for i in cells
            {
                let cell: exerciseCell = i as! exerciseCell
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            }
        }
        else if randomAnim == 3
        {
            for i in cells
            {
                let cell: exerciseCell = i as! exerciseCell
                cell.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
            }
        }
        else if randomAnim == 4
        {
            for i in cells
            {
                let cell: exerciseCell = i as! exerciseCell
                cell.transform = CGAffineTransform(translationX: 0, y: -(1.2*tableHeight))
            }
        }
        else if randomAnim == 5
        {
            table.transform = CGAffineTransform(translationX: viewWidth, y: 0)
            table.alpha = 0
        }
        
        if !isIpad
        {
            var index = 0
            
            for a in cells
            {
                let cell: exerciseCell = a as! exerciseCell
                UIView.animateWithDuration(1.5, delay: 0.06 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
                    cell.transform = CGAffineTransformMakeTranslation(0, 0);
                    }, completion: nil)
                index += 1
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.7, delay: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.exerciseTitle.alpha = 1.0
            self.time.alpha = 1.0
            self.startButton.alpha = 1.0
            self.setsButton.alpha = 1.0
            self.infoButton.alpha = 1.0
            if self.isIpad
            {
                self.table.alpha = 1
                self.table.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            }, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.revealViewController().rearViewRevealWidth = 180
        self.revealViewController().rightViewRevealWidth = 170
        
        exerciseTitle.text = AppManager.sharedInstance.cualExercise.name
        exerciseList = AppManager.sharedInstance.cualExercise.exercises
        
        self.currentColors = AppManager.sharedInstance.cualesColores
        
        if exerciseTitle.text == "unassigned"
        {
            AppManager.sharedInstance.cualExercise = AppManager.sharedInstance.original
            exerciseTitle.text = AppManager.sharedInstance.cualExercise.name
            exerciseList = AppManager.sharedInstance.cualExercise.exercises
            
            AppManager.sharedInstance.cualesColores = AppManager.sharedInstance.preset1
            self.currentColors = AppManager.sharedInstance.cualesColores
        }
        
        setsButton.setTitle("SETS: \(AppManager.sharedInstance.cualExercise.currentSets)", for: UIControlState())
        
        let total = self.calculateTotalTime()*AppManager.sharedInstance.cualExercise.currentSets
        let segundos = total%60
        let minutos = (total-segundos)/60
        
        time.text = "Time: \(minutos)min \(segundos)sec"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            return 100
        }
        else
        {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath) as! exerciseCell
        
        // Configure the cell...
        
        cell.numberLabel.text = "\(indexPath.row+1)."
        cell.titleLabel.text = "\(exerciseList[indexPath.row])"
        cell.exerciseImage.image = UIImage(named: "\(exerciseList[indexPath.row])")
        
        //cell.backgroundColor = UIColor.clearColor()
        
        var index = indexPath.row
        if indexPath.row<5{index=indexPath.row}
        else if indexPath.row<10{index=indexPath.row-5}
        else if indexPath.row<15{index=indexPath.row-10}
        else if indexPath.row<20{index=indexPath.row-15}
        else if indexPath.row<25{index=indexPath.row-20}
        
        var hue: (CGFloat) = 0.0
        var sat: (CGFloat) = 0.0
        var light: (CGFloat) = 0.0
        var al: (CGFloat) = 0.0
        
        AppManager.sharedInstance.cualesColores.colorSet[index].getHue(&hue, saturation: &sat, brightness: &light, alpha: &al)
        
        cell.numberLabel.backgroundColor = UIColor(hue: hue, saturation: sat, brightness: light-0.2, alpha: al)
        
        cell.backgroundColor = UIColor(hue: hue, saturation: sat, brightness: light, alpha: al)
        
        cell.numberLabel.textColor = UIColor.white
        cell.titleLabel.textColor = UIColor.white
        
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
        return "\(AppManager.sharedInstance.cualExercise.sets[row]) - \(AppManager.sharedInstance.cualExercise.setDescription[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.alpha = 0
        startButton.isEnabled = true
        setsButton.isEnabled = true
        table.alpha = 1
        
        AppManager.sharedInstance.cualExercise.currentSets = AppManager.sharedInstance.cualExercise.sets[row]
        setsButton.setTitle("SETS: \(AppManager.sharedInstance.cualExercise.currentSets)", for: UIControlState())
        
        let total = self.calculateTotalTime()*AppManager.sharedInstance.cualExercise.currentSets
        let segundos = total%60
        let minutos = (total-segundos)/60
        
        time.text = "Time: \(minutos)min \(segundos)sec"
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        let titleData = "\(AppManager.sharedInstance.cualExercise.sets[row]) - \(AppManager.sharedInstance.cualExercise.setDescription[row])"
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName: UIFont(name: "Oswald", size:25)!,NSForegroundColorAttributeName:UIColor.black])
        pickerLabel.attributedText = myTitle
        
        pickerLabel.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    @IBAction func startWorkoutButtonPressed(_ sender: AnyObject)
    {
        AppManager.sharedInstance.customOrNot = 1
        UIApplication.shared.isIdleTimerDisabled = true
        
        let speechUtterance = AVSpeechUtterance(string: AppManager.sharedInstance.cualExercise.name)
        speechUtterance.rate = rate
        speechUtterance.pitchMultiplier = pitchMultiplier
        speechUtterance.volume = volume
        speechSynthesizer.speak(speechUtterance)
    }
    @IBAction func cancelWorkout(_ segue:UIStoryboardSegue)
    {
        
    }
    
    @IBAction func infoButtonPressed(_ sender: AnyObject)
    {
        let alert = UIAlertController(title: "Workout Info", message: AppManager.sharedInstance.cualExercise.routineDescription, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Let's do it!", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func menuButtonPressed(_ sender: AnyObject)
    {
        
        self.revealViewController().revealToggle(nil)
        
    }
    
    
    @IBAction func setsButtonPressed(_ sender: AnyObject)
    {
        pickerView.alpha = 1
        startButton.isEnabled = false
        setsButton.isEnabled = false
        table.alpha = 0
    }
    
    func calculateTotalTime () ->Int
    {
        var totalTime = 0
        
        for i in AppManager.sharedInstance.cualExercise.exerciseTimes
        {
            totalTime += i
        }
        
        for i in AppManager.sharedInstance.cualExercise.waitTimes
        {
            totalTime += i
        }
        
        //totalTime += AppManager.sharedInstance.cualExercise.setWaitTime * (AppManager.sharedInstance.cualExercise.currentSets-1)
        
        return totalTime
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
