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
    
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if(flag) {
//            recordedAudio = RecordedAudio(
//                audioFilePathURL: recorder.url as NSURL,
//                audioTitle: recorder.url.lastPathComponent)
//            // substitute a harcoded audio file here:
//            recordedAudio = getTestAudioFile(testFile: "IronMan_420-425secs")
//            print(recorder.url)
//        } else {
//            print("recording was not successful")
//        }
//    }
    
    func stopRecording() {
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func getTestAudioFile(testFile: String) -> RecordedAudio {
        let nsurl = Bundle.main.url(forResource: testFile, withExtension: "wav")! as NSURL
        return RecordedAudio(audioFilePathURL: nsurl, audioTitle: testFile)
    }
}
