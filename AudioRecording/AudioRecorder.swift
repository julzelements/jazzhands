import UIKit
import AVFoundation

class AudioRecorder: NSObject, AVAudioRecorderDelegate {
    
    init(delegate: AVAudioRecorderDelegate) {
        super.init()
        parentViewController = delegate
    }
    
    var parentViewController: AVAudioRecorderDelegate!
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    func recordAudio() {
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        audioRecorder.delegate = parentViewController
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        //get system time
        audioRecorder.record()
    }
    
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}
