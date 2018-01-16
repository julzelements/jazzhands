//
//  TimeStampSet.swift
//  Jammies
//
//  Created by Julian Scharf on 18/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import Foundation

class TimeStampSet {
    var time: ITime
    
    init(time: ITime) {
        self.time = time
    }
    
    var timeWhenPhoneBeganListening: Double!
    var timeWhenAPIWasCalled: Double!
    var timeWhenAPIReturnedAndPlayerStarted: Double!
    
    func setTimeWhenPhoneBeganListening() { timeWhenPhoneBeganListening = time.systemTime }
    func setTimeWhenAPIWasCalled() { timeWhenAPIWasCalled = time.systemTime }
    func setTimeWhenAPIReturnedAndPlayerStarted() { timeWhenAPIReturnedAndPlayerStarted = time.systemTime }
}
