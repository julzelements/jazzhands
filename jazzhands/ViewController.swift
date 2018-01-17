//
//  ViewController.swift
//  jazzhands
//
//  Created by Julian Scharf on 15/1/18.
//  Copyright © 2018 Julian Scharf. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate{
    
    @IBOutlet weak var subtitleOutput: UITextView!

    var audioRecorder: AudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioRecorder = AudioRecorder(delegate: self)
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

    
}

