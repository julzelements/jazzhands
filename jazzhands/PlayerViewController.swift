//
//  PlayerViewController.swift
//  TimeMock
//
//  Created by Julian Scharf on 6/9/17.
//  Copyright © 2017 Julian Scharf. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var label: UILabel!
    var apiSystemTime: Double!
    var apiMovieTime: Double!
    var player: Player!
    var events: SubtitleEvents!
    var time: MyTime!
    var recordedAudioURL: URL!
    var audioRecorder: AudioRecorder!
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioRecorder = AudioRecorder(delegate: self)
    }
    
    func setup() {
        //pretend that the api was called 8.5 seconds ago
        apiSystemTime = Date.timeIntervalSinceReferenceDate - 0.0
        apiMovieTime = callApi()
        time = MyTime()
        events = getEvents()
        
        player = Player(apiSystemTime: apiSystemTime, apiMovieTime: apiMovieTime, arrayOfEvents: events, time: time)
        
        getReadyForTheNextSubtitle()
    }
    
    
    @IBAction func play(_ sender: Any) {
        setup()
    }
    
    @IBAction func record(_ sender: Any) {
        audioRecorder.recordAudio()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        audioRecorder.stopRecording()
    }
    
    @IBAction func printAudioData(_ sender: Any) {
        print(recordedAudioURL)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print(recorder.url)
    }
    
    func getEvents() -> SubtitleEvents {
        let rawSubs = SubtitleIO.getRawStringFromFileInBundle(fileName: "IronMan", fileExtension: "srt")
        return SubtitleEvents(rawSRTString: rawSubs)
    }
    
    func callApi() -> Double {
        let movieTime = 420.0
        return movieTime
        
        let formCreator = AudioFormCreator(audioFilePath: self.recordedAudioURL)
        let request = formCreator.createMultiformPOSTRequest()
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            if let data = data,
                let string = String(data: data, encoding: .utf8) {
                print(string)
                //extract movie time
                self.apiMovieTime = 35.5
            }
        }
        task.resume()
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
