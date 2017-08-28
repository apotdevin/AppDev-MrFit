//
//  SetsInterfaceController.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/25/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import WatchKit
import Foundation


class SetsInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var setsTable: WKInterfaceTable!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    
    var randomPalette = WatchColor()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        self.titleLabel.setText("\(WatchManager.sharedInstance.cualExercise.name) Sets:")
        
        self.reloadTable()
        println("llego a sets IController")
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func reloadTable()
    {
        let rows = WatchManager.sharedInstance.cualExercise.sets.count
        
        setsTable.setNumberOfRows(rows, withRowType: "SetRow")
        
        let randomColor = arc4random_uniform(8)
        randomPalette = WatchManager.sharedInstance.colorArray[Int(randomColor)]
        
        for i in 0 ..< rows
        {
            if let row = self.setsTable.rowController(at: i) as? SetRow
            {
                row.numberLabel.setText("\(WatchManager.sharedInstance.cualExercise.sets[i])")
                row.setLabel.setText(WatchManager.sharedInstance.cualExercise.setDescription[i])
                row.group.setBackgroundColor(self.setRowColor(i))
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
        
        if let row = self.setsTable.rowController(at: rowIndex) as? SetRow
        {
            WatchManager.sharedInstance.cualExercise.currentSets = WatchManager.sharedInstance.cualExercise.sets[rowIndex]
            println(WatchManager.sharedInstance.cualExercise.sets[rowIndex])
        }
        
        return nil
    }
}
