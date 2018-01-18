import UIKit
import AVFoundation

class PlayerViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var label: UILabel!
    var systemTimeWhenRecordingStarted: Double!
    var apiMovieTime: Double!
    var player: Player!
    var events: SubtitleEvents!
    var time: MyTime!
    var recordedAudio: RecordedAudio!
    var audioRecorder: AudioRecorder!
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioRecorder = AudioRecorder(delegate: self)
    }
    
    func createPlayer() {
        time = MyTime()
        events = getEvents()
        player = Player(apiSystemTime: systemTimeWhenRecordingStarted, apiMovieTime: apiMovieTime, arrayOfEvents: events, time: time)
    }
    
    @IBAction func play(_ sender: Any) {
        logSystemTime(description: "play button was pushed")
        createPlayer()
        getReadyForTheNextSubtitle()
    }
    
    @IBAction func record(_ sender: Any) {
        setSystemTimeWhenRecordingStarts()
        logSystemTime(description: "record button was pushed")
        audioRecorder.recordAudio()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        audioRecorder.stopRecording()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            print("recording successful")
            recordedAudio = RecordedAudio(
                audioFilePathURL: recorder.url as NSURL,
                audioTitle: recorder.url.lastPathComponent)
            print("recorded audio url: \(recorder.url)")
            // substitute a harcoded audio file here:
            // recordedAudio = getTestAudioFile(testFile: "IronMan_420-425secs")
            // print("using test audio file \(recordedAudio.title)")
            sendRequest()
        } else {
            print("recording was not successful")
        }
    }
    
    func getEvents() -> SubtitleEvents {
        let rawSubs = SubtitleIO.getRawStringFromFileInBundle(fileName: "IronMan", fileExtension: "srt")
        return SubtitleEvents(rawSRTString: rawSubs)
    }
    
    func sendRequest(){
        let formCreator = AudioFormCreator(audioFilePath: self.recordedAudio.filePathURL as URL)
        let request = formCreator.createMultiformPOSTRequest()
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
            if let data = data,
                let string = String(data: data, encoding: .utf8) {
                print(string)
                let offset = DejavuPayload(json: string).offset!
                self.setMovieTime(time: offset)
                print("player is ready")
            }
        }
        task.resume()
    }
    
    func setSystemTimeWhenRecordingStarts() {
        systemTimeWhenRecordingStarted = Date.timeIntervalSinceReferenceDate
        logSystemTime(description: "Recording Started")
    }
    
    func setMovieTime(time: Double) {
        apiMovieTime = time
    }
    
    func makeATimer(interval: Double) {
        timer = Timer(timeInterval: interval, target: self, selector: (#selector(PlayerViewController.getReadyForTheNextSubtitle)), userInfo: nil, repeats: false)
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
    }
    
    func printCurrentSubtitle() {
        let currentSubtitle = events[player.currentSubtitleIndex]
        print(currentSubtitle)
        logSystemTime(description: "time since recording started:")
        label.text = currentSubtitle.text
    }
    
    @objc func getReadyForTheNextSubtitle() {
        player.updatePlayer(time: time)
        printCurrentSubtitle()
        let interval = player.timeIntervalToNextSubtitle
        makeATimer(interval: interval!)
    }
    
    func getTestAudioFile(testFile: String) -> RecordedAudio {
        let nsurl = Bundle.main.url(forResource: testFile, withExtension: "wav")! as NSURL
        return RecordedAudio(audioFilePathURL: nsurl, audioTitle: testFile)
    }
    
    func logSystemTime(description: String) {
        print("\(description): \(Date.timeIntervalSinceReferenceDate - systemTimeWhenRecordingStarted)")
    }
}
