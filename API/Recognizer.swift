import Foundation

class Recognizer {
    
    var audioURL: URL!
    
    init(audioURL: URL) {
        self.audioURL = audioURL
    }
    
    func recognize() {
        let apiSystemTime = MyTime().systemTime
        let ironManSRTBlob = SubtitleIO.getRawStringFromFileInBundle(fileName: "IronMan", fileExtension: "srt")
        let events = SubtitleEvents(rawSRTString: ironManSRTBlob)
        let formCreator = AudioFormCreator(audioFilePath: audioURL!)
        let request = formCreator.createMultiformPOSTRequest()
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, _) in
             if let data = data,
                let string = String(data: data, encoding: .utf8) {
                print(string)
                
                //extract movie time
                
                let apiMovieTime = 35.5
                
                let player = StateCalculator(apiSystemTime: apiSystemTime, apiMovieTime: apiMovieTime, arrayOfEvents: events, time: MyTime())
            }
            
        }
        task.resume()
    }
}
