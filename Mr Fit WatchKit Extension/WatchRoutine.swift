//
//  WatchRoutine.swift
//  Mr Fit
//
//  Created by Anthony Potdevin on 5/25/15.
//  Copyright (c) 2015 Anthony Potdevin. All rights reserved.
//

import UIKit

class WatchRoutine: NSObject {
    var name = "unassigned"
    //var routineDescription = "empty description"
    var exercises: [String] = ["Empty"]
    var waitTimes: [NSInteger] = [0]
    var exerciseTimes: [NSInteger] = [0]
    var setWaitTime = 0
    var sets: [NSInteger] = [0]
    var setDescription: [String] = ["Empty"]
    var currentSets = 0
}
