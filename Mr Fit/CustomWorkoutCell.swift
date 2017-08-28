//
//  CustomWorkoutCell.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 6/1/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class CustomWorkoutCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var exerciseTimeSlider: UISlider!
    @IBOutlet weak var waitTimeSlider: UISlider!
    @IBOutlet weak var exerciseTimeLabel: UILabel!
    @IBOutlet weak var waitTimeLabel: UILabel!
    @IBOutlet weak var exerciseButton: UIButton!
    @IBOutlet weak var exerciseImageView: UIImageView!
    @IBOutlet weak var exerciseTitleLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func exerciseButtonPressed(_ sender: UIButton)
    {
        exerciseButton.isEnabled = false
        picker.alpha = 1
        
    }
    
    @IBAction func exerciseTimeSliderChanged(_ sender: UISlider)
    {
        self.exerciseTimeLabel.text = " Exercise Time: \(Int(sender.value)) sec"
        
        AppManager.sharedInstance.customWorkoutTimes[sender.tag] = Int(sender.value)
        
        //AppManager.sharedInstance.customWorkoutTimes.insert(Int(sender.value), atIndex: sender.tag+1)
        //AppManager.sharedInstance.customWorkoutTimes.removeAtIndex(sender.tag)
    }
    
    @IBAction func waitTimeSliderChanged(_ sender: UISlider)
    {
        self.waitTimeLabel.text = " Wait Time: \(Int(sender.value)) sec"
        
        AppManager.sharedInstance.customWorkoutWait[sender.tag] = Int(sender.value)
        
        //AppManager.sharedInstance.customWorkoutWait.insert(Int(sender.value), atIndex: sender.tag+1)
        //AppManager.sharedInstance.customWorkoutWait.removeAtIndex(sender.tag)
    }
    
    //--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // MARK: - Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AppManager.sharedInstance.allExercises.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(AppManager.sharedInstance.allExercises[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.alpha = 0
        exerciseButton.isEnabled = true
        
        AppManager.sharedInstance.customWorkoutExercises[exerciseButton.tag] = AppManager.sharedInstance.allExercises[row]
        
        //AppManager.sharedInstance.customWorkoutExercises.insert(AppManager.sharedInstance.allExercises[row], atIndex: exerciseButton.tag+1)
        //AppManager.sharedInstance.customWorkoutExercises.removeAtIndex(exerciseButton.tag)
        
        exerciseTitleLabel.text = AppManager.sharedInstance.allExercises[row]
        exerciseImageView.image = UIImage(named: AppManager.sharedInstance.allExercises[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        let titleData = "\(AppManager.sharedInstance.allExercises[row])"
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName: UIFont(name: "Oswald", size:20)!,NSForegroundColorAttributeName:UIColor.white])
        pickerLabel.attributedText = myTitle
        
        pickerLabel.backgroundColor = UIColor.black
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
}
