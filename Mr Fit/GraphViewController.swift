//
//  GraphViewController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/17/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, LineChartDelegate {
    
    @IBOutlet weak var lineChart: LineChart!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    
    var dateArray:[Date] = []
    var scoreArray:[CGFloat] = []
    
    override func viewWillAppear(_ animated: Bool) {
        
        let dailyWorkout = AppManager.sharedInstance.dailyWorkout
        
        if dailyWorkout.count == 1
        {
            dateArray.append(Date())
            scoreArray.append(CGFloat(0))
        }
        else if dailyWorkout.count == 0
        {
            dateArray.append(Date())
            scoreArray.append(CGFloat(0))
            dateArray.append(Date())
            scoreArray.append(CGFloat(0))
        }
        
        for array in dailyWorkout
        {
            let date = array[0] as! Date
            let score = array[1] as! Int
            
            let score1 = CGFloat(score)
            
            dateArray.append(date)
            scoreArray.append(score1)
        }
        /*
        for var i=0;i<15;i++
        {
            dateArray.append(NSDate(timeIntervalSinceNow: NSTimeInterval(58*60*24*i)))
        }
        scoreArray.append(CGFloat(360))
        scoreArray.append(CGFloat(500))
        scoreArray.append(CGFloat(560))
        scoreArray.append(CGFloat(700))
        scoreArray.append(CGFloat(650))
        scoreArray.append(CGFloat(200))
        scoreArray.append(CGFloat(550))
        scoreArray.append(CGFloat(1100))
        scoreArray.append(CGFloat(640))
        scoreArray.append(CGFloat(800))
        scoreArray.append(CGFloat(750))
        scoreArray.append(CGFloat(810))
        scoreArray.append(CGFloat(720))
        scoreArray.append(CGFloat(230))
        scoreArray.append(CGFloat(420))
        */
        //println("\(scoreArray)")
        
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
        
        lineChart.colors = [UIColor.orange]
        
        lineChart.animation.duration = 1.5
        lineChart.lineWidth = 5
        
        lineChart.x.grid.visible = false
        lineChart.y.grid.visible = false
        
        self.lineChart.addLine(self.scoreArray)
        
        self.titleLabel.alpha = 0
        self.dateLabel.alpha = 0
        self.minutesLabel.alpha = 0
        self.lineChart.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animateWithDuration(1, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.titleLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.dateLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.15, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
            self.minutesLabel.alpha = 1
            }, completion: nil)
        UIView.animateWithDuration(1, delay: 0.2, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: nil, animations: {
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
    
    
    func didSelectDataPoint(_ x: CGFloat, yValues: Array<CGFloat>)
    {
        let index = Int(x)
        
        if index<dateArray.count
        {
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .none
            
            let dateString = formatter.string(from: dateArray[index])
            
            let total = yValues[0]
            let segundos = total.truncatingRemainder(dividingBy: 60)
            let minutos = (total-segundos)/60
            
            if yValues[0] != 0
            {
                self.dateLabel.text = " Date: \(dateString)"
                self.minutesLabel.text = " Workout Time: \(Int(minutos))min \(Int(segundos))sec"
            }
            else
            {
                self.dateLabel.text = " Date: ..."
                self.minutesLabel.text = " Workout Time: ..."
            }
        }
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
}
