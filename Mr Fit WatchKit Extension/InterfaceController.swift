//
//  InterfaceController.swift
//  Mr Fit WatchKit Extension
//
//  Created by Anthony Potdevin on 5/25/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    var randomPalette = WatchColor()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        WatchManager.sharedInstance.startWatchApp()
        self.reloadTable()
        
        println("Empezo IController")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func reloadTable()
    {
        let rows = WatchManager.sharedInstance.menuItems.count
        
        if WatchManager.sharedInstance.armInfo == 5201
        {
            let amount = WatchManager.sharedInstance.menuItems.count-1
            var rowTypes = [String]()
            
            for i in 0 ..< amount
            {
                rowTypes.append("WorkoutRow")
            }
            rowTypes.append("CustomWorkoutRow")
            
            table.setRowTypes(rowTypes)
            
            let randomColor = arc4random_uniform(8)
            randomPalette = WatchManager.sharedInstance.colorArray[Int(randomColor)]
            
            for i in 0 ..< rows
            {
                if i<rows-1
                {
                    if let row = self.table.rowController(at: i) as? WorkoutRow
                    {
                        row.workoutLabel.setText("\(WatchManager.sharedInstance.menuItems[i])")
                        row.group.setBackgroundColor(self.setRowColor(i))
                    }
                }
                else
                {
                    if let row = self.table.rowController(at: i) as? CustomWorkoutRow
                    {
                        row.workoutLabel.setText(WatchManager.sharedInstance.menuItems[i])
                        row.group.setBackgroundColor(self.setRowColor(i))
                    }
                }
            }
        }
        else
        {
            table.setNumberOfRows(rows, withRowType: "WorkoutRow")
            
            for i in 0 ..< rows
            {
                if let row = self.table.rowController(at: i) as? WorkoutRow
                {
                    row.workoutLabel.setText("\(WatchManager.sharedInstance.menuItems[i])")
                    row.group.setBackgroundColor(self.setRowColor(i))
                }
            }
        }
        
    }
    
    func setRowColor(_ rowIndex: Int) -> UIColor
    {
        var whichOne = rowIndex
        if whichOne >= 15
        {
            whichOne = whichOne - 5
        }
        if whichOne >= 10
        {
            whichOne = whichOne - 5
        }
        if whichOne >= 5
        {
            whichOne = whichOne - 5
        }
        
        return randomPalette.colorSet[whichOne]
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        
        if rowIndex == 0
        {
            WatchManager.sharedInstance.cualExercise = WatchManager.sharedInstance.original
        }
        else if rowIndex == 1
        {
            WatchManager.sharedInstance.cualExercise = WatchManager.sharedInstance.steelAbs
        }
        else if rowIndex == 2
        {
            WatchManager.sharedInstance.cualExercise = WatchManager.sharedInstance.batman
        }
        else if rowIndex == 3
        {
            WatchManager.sharedInstance.cualExercise = WatchManager.sharedInstance.twoMinAbs
        }
        else if rowIndex == 4
        {
            WatchManager.sharedInstance.cualExercise = WatchManager.sharedInstance.legDay
        }
        else if rowIndex == 5
        {
            WatchManager.sharedInstance.cualExercise = WatchManager.sharedInstance.navySeal
        }
        else if rowIndex == 6
        {
            WatchManager.sharedInstance.cualExercise = WatchManager.sharedInstance.ninja
        }
        else if rowIndex == 7
        {
            WatchManager.sharedInstance.cualExercise = WatchManager.sharedInstance.aquaman
        }
        
        return nil
    }
}
