//
//  MyTime.swift
//  TimeMock
//
//  Created by Julian Scharf on 5/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import UIKit
import Foundation

class MyTime: ITime {
    var systemTime: Double {
        get {
            return Date.timeIntervalSinceReferenceDate
        }
    }
}
