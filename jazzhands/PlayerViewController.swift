//
//  PlayerViewController.swift
//  TimeMock
//
//  Created by Julian Scharf on 6/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    var apiSystemTime: Double!
    var apiMovieTime: Double!
    var player: Player!
    var events: SubtitleEvents!
    var time: MyTime!
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pretend that the api was called 8.5 seconds ago
        apiSystemTime = Date.timeIntervalSinceReferenceDate - 8.5
        apiMovieTime = callApi()
        time = MyTime()
        events = getEvents()
        
        player = Player(apiSystemTime: apiSystemTime, apiMovieTime: apiMovieTime, arrayOfEvents: events, time: time)
        
        getReadyForTheNextSubtitle()
    }

    func getEvents() -> SubtitleEvents {
        let rawSubs = SubtitleIO.getRawStringFromFileInBundle(fileName: "IronMan", fileExtension: "srt")
        return SubtitleEvents(rawSRTString: rawSubs)
    }
    
    func callApi() -> Double {
        let movieTime = 400.0
        return movieTime
    }
    
    func makeATimer(interval: Double) {
        print("interval: \(interval)")
        print("SystemTime: \(Date.timeIntervalSinceReferenceDate - apiSystemTime)")
        timer = Timer(timeInterval: interval, target: self, selector: (#selector(PlayerViewController.getReadyForTheNextSubtitle)), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
    }
    
    func printCurrentSubtitle() {
        let currentSubtitle = events[player.currentSubtitleIndex]
        print(currentSubtitle)
        label.text = currentSubtitle.text
    }
    
    @objc func getReadyForTheNextSubtitle() {
        player.updatePlayer(time: time)
        printCurrentSubtitle()
        let interval = player.timeIntervalToNextSubtitle
        makeATimer(interval: interval!)
    }
}
