//
//  Graph2ViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/18/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class Graph2ViewController: UIViewController, LineChartDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var lineChart: LineChart!
    
    let kgOrLb = AppManager.sharedInstance.kgOrLb
    var unitString = ""
    var unitValue = 70
    var unitMultiplier = 1.0
    
    var dailyWeight = AppManager.sharedInstance.dailyWeight
    
    var dateArray:[Date] = []
    var weightArray:[CGFloat] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        if kgOrLb
        {
            unitString = "lb"
            unitMultiplier = 2.204
        }
        else
        {
            unitString = "kg"
            unitMultiplier = 1.0
        }
        
        let modifiedValue = Int(unitMultiplier*Double(unitValue))
        
        self.addLabel.text = " Add: \(modifiedValue)\(unitString)"
        
        let lastItem = AppManager.sharedInstance.dailyWeight.count
        if lastItem == 0
        {
            self.removeLabel.text = " Last: NONE"
        }
        else
        {
            let last = dailyWeight[lastItem-1]
            let lastWeight = last[1] as! Int
            
            self.removeLabel.text = " Last: \(Int(unitMultiplier*Double(lastWeight)))\(unitString)"
        }
        
        //println("\(dailyWeight.count)")
        
        if dailyWeight.count == 0
        {
            dateArray.append(Date())
            weightArray.append(CGFloat(0))
            dateArray.append(Date())
            weightArray.append(CGFloat(0))
        }
        else if dailyWeight.count == 1
        {
            dateArray.append(Date())
            weightArray.append(CGFloat(0))
        }
        
        for array in dailyWeight
        {
            let date = array[0] as! Date
            var weight = array[1] as! Int
            
            weight = Int(Double(weight)*unitMultiplier)
            
            let weight1 = CGFloat(weight)
            
            dateArray.append(date)
            weightArray.append(weight1)
        }
        /*
        for var i=0;i<15;i++
        {
            dateArray.append(NSDate(timeIntervalSinceNow: NSTimeInterval(58*60*24*i)))
        }
        weightArray.append(CGFloat(100))
        weightArray.append(CGFloat(88))
        weightArray.append(CGFloat(85))
        weightArray.append(CGFloat(78))
        weightArray.append(CGFloat(85))
        weightArray.append(CGFloat(80))
        weightArray.append(CGFloat(75))
        weightArray.append(CGFloat(71))
        weightArray.append(CGFloat(70))
        weightArray.append(CGFloat(71))
        weightArray.append(CGFloat(70))
        weightArray.append(CGFloat(68))
        weightArray.append(CGFloat(70))
        weightArray.append(CGFloat(69))
        weightArray.append(CGFloat(67))
        */
        //println("\(weightArray)")
        
        lineChart.delegate = self
        
        lineChart.animation.enabled = true
        lineChart.area = false
        
        lineChart.x.labels.visible = false
        lineChart.y.labels.visible = false
        
        lineChart.x.axis.color = UIColor.clear
        lineChart.y.axis.color = UIColor.clear
        
        lineChart.dots.outerRadiusHighlighted = CGFloat(15)
        lineChart.dots.innerRadiusHighlighted = CGFloat(10)
        
        lineChart.dots.outerRadius = CGFloat(15)
        lineChart.dots.innerRadius = CGFloat(10)
        
        lineChart.colors = [UIColor.yellow]
        
        lineChart.animation.duration = 1.5
        lineChart.lineWidth = 5
        
        lineChart.x.grid.visible = false
        lineChart.y.grid.visible = false
        
        lineChart.addLine(weightArray)
        
        self.titleLabel.alpha = 0
        
        self.addLabel.alpha = 0
        self.minusButton.alpha = 0
        self.plusButton.alpha = 0
        self.addButton.alpha = 0
        
        self.removeLabel.alpha = 0
        self.deleteButton.alpha = 0
        
        self.dateLabel.alpha = 0
        
        self.weightLabel.alpha = 0
        
        self.lineChart.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIView.animateWithDuration(1, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.titleLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.addLabel.alpha = 1
            self.minusButton.alpha = 1
            self.plusButton.alpha = 1
            self.addButton.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.removeLabel.alpha = 1
            self.deleteButton.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.dateLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.weightLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.35, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.lineChart.alpha = 1
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func minusButtonPressed(_ sender: AnyObject)
    {
        self.unitValue -= 1
        let modifiedValue = Int(Double(self.unitValue)*unitMultiplier)
        self.addLabel.text = " Add: \(modifiedValue)\(unitString)"
    }
    @IBAction func plusButtonPressed(_ sender: AnyObject)
    {
        self.unitValue += 1
        let modifiedValue = Int(Double(self.unitValue)*unitMultiplier)
        self.addLabel.text = " Add: \(modifiedValue)\(unitString)"
    }
    
    @IBAction func addButtonPressed(_ sender: AnyObject)
    {
        self.addButton.isEnabled = false
        
        //println("hay \(AppManager.sharedInstance.dailyWeight.count) pesos")
        
        var lastItem = AppManager.sharedInstance.dailyWeight.count
        
        if lastItem == 0
        {
            //println("pesos estan vacios")
            let today = [Date(),self.unitValue] as [Any]
            AppManager.sharedInstance.dailyWeight.append(today as NSArray)
        }
        else
        {
            let dateArray = AppManager.sharedInstance.dailyWeight[lastItem-1]
            
            let pastDate = dateArray[0] as! Date
            let currentDate = Date()
            
            let pastScore = dateArray[1] as! Int
            
            let calender = Calendar.current
            let components = calender.components(NSCalendar.Unit.CalendarUnitDay, fromDate: currentDate, toDate: pastDate, options: nil).day
            //println("dias de por medio: \(components)")
            
            if components == 0
            {
                let today = [pastDate,self.unitValue] as [Any]
                AppManager.sharedInstance.dailyWeight[lastItem-1] = today as NSArray
            }
            else
            {
                let today = [Date(),self.unitValue] as [Any]
                AppManager.sharedInstance.dailyWeight.append(today as NSArray)
            }
            
        }
        
        self.dailyWeight = AppManager.sharedInstance.dailyWeight
        UserDefaults.standard.set(self.dailyWeight, forKey: "dailyWeight")
        
        lineChart.clear()
        self.remakeArrays()
        lineChart.addLine(weightArray)
        
        lastItem = AppManager.sharedInstance.dailyWeight.count
        if lastItem == 0
        {
            self.removeLabel.text = " Last: NONE"
        }
        else
        {
            let last = dailyWeight[lastItem-1]
            let lastWeight = last[1] as! Int
            
            self.removeLabel.text = " Last: \(Int(unitMultiplier*Double(lastWeight)))\(unitString)"
        }
    }
    @IBAction func deleteButtonPressed(_ sender: AnyObject)
    {
        self.addButton.isEnabled = true
        
        //println("hay \(AppManager.sharedInstance.dailyWeight.count) pesos")
        
        var lastItem = AppManager.sharedInstance.dailyWeight.count
        
        if lastItem != 0
        {
            AppManager.sharedInstance.dailyWeight.removeLast()
        }
        
        self.dailyWeight = AppManager.sharedInstance.dailyWeight
        UserDefaults.standard.set(self.dailyWeight, forKey: "dailyWeight")
        
        if lastItem != 0
        {
            lineChart.clear()
            self.remakeArrays()
            lineChart.addLine(weightArray)
        }
        
        lastItem = AppManager.sharedInstance.dailyWeight.count
        if lastItem == 0
        {
            self.removeLabel.text = " Last: NONE"
        }
        else
        {
            let last = dailyWeight[lastItem-1]
            let lastWeight = last[1] as! Int
            
            self.removeLabel.text = " Last: \(Int(unitMultiplier*Double(lastWeight)))\(unitString)"
        }
    }
    
    func remakeArrays()
    {
        dateArray = []
        weightArray = []
        
        if dailyWeight.count == 0
        {
            dateArray.append(Date())
            weightArray.append(CGFloat(0))
            dateArray.append(Date())
            weightArray.append(CGFloat(0))
        }
        else if dailyWeight.count == 1
        {
            dateArray.append(Date())
            weightArray.append(CGFloat(0))
        }
        
        for array in dailyWeight
        {
            let date = array[0] as! Date
            var weight = array[1] as! Int
            
            weight = Int(Double(weight)*unitMultiplier)
            
            let weight1 = CGFloat(weight)
            
            dateArray.append(date)
            weightArray.append(weight1)
        }
        //println("\(weightArray)")
    }
    
    func didSelectDataPoint(_ x: CGFloat, yValues: Array<CGFloat>)
    {
        var index = Int(x)
        
        if index<dateArray.count
        {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .none
            
            println("\(dateArray.count) total. \(index) needed.")
            
            let dateString = formatter.string(from: dateArray[index])
            
            if yValues[0] != 0
            {
                self.dateLabel.text = " Date: \(dateString)"
                self.weightLabel.text = " Weight: \(yValues[0]) \(unitString)"
            }
            else
            {
                self.dateLabel.text = " Date: ..."
                self.weightLabel.text = " Weight: ..."
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
