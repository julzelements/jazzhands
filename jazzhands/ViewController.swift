//
//  ViewController.swift
//  jazzhands
//
//  Created by Julian Scharf on 15/1/18.
//  Copyright © 2018 Julian Scharf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var subtitleOutput: UITextView!

    @IBAction func loadSubs(_ sender: UIButton) {
        loadSubtitleFile()
    }
    var audioRecorder: AudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioRecorder = AudioRecorder()
        subtitleOutput.backgroundColor = UIColor.blue
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        print("started recording")
        self.audioRecorder.recordAudio()
               subtitleOutput.backgroundColor = UIColor.yellow
    }

    @IBAction func stopRecording(_ sender: Any) {
        print("stopped recording")
        self.audioRecorder.stopRecording()
               subtitleOutput.backgroundColor = UIColor.green
    }
    
    func loadSubtitleFile() {
        let rawString = SubtitleIO.getRawStringFromFileInBundle(fileName: "spiderman", fileExtension: "srt")
        
        let myEvents = SubtitleEvents(rawSRTString: rawString)
        
        let systemTime = MyTime()
        
        var player = Player(apiSystemTime: 12, apiMovieTime: 12, arrayOfEvents: myEvents, time: systemTime)
    

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

