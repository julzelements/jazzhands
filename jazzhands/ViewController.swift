//
//  ViewController.swift
//  jazzhands
//
//  Created by Julian Scharf on 15/1/18.
//  Copyright © 2018 Julian Scharf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var audioRecorder: AudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.audioRecorder = AudioRecorder()
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        print("started recording")
        self.audioRecorder.recordAudio()
    }

    @IBAction func stopRecording(_ sender: Any) {
        print("stopped recording")
        self.audioRecorder.stopRecording()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

