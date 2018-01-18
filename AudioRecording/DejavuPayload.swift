import Foundation

class DejavuPayload {
    
    var jsonDictionary: [String: String]!
    var offset: Double!
    
    init(json: String) {
        let scrubbed = scrubCharacters(jsonFromDejavu: json)
        let split = splitWithCommas(scrubbed: scrubbed)
        let parsed = parse(array: split)
        self.jsonDictionary = parsed
        
        self.offset = toDouble(string: parsed["offset_seconds"]!)
    }
    
    func scrubCharacters(jsonFromDejavu: String) -> String {
        let scrubbed = jsonFromDejavu
            .replacingOccurrences(of: "\\", with: "")
            .replacingOccurrences(of: "'", with: "")
            .replacingOccurrences(of: "{", with: "")
            .replacingOccurrences(of: "}", with: "")
            .replacingOccurrences(of: " ", with: "")
        return scrubbed
    }
    
    func splitWithCommas(scrubbed: String) -> [String] {
        let split = scrubbed.split(separator: ",")
        let toStrings = split.map {String($0)}
        return toStrings
    }
    
    func parse(array: [String]) -> [String: String] {
        var dictionary = [String: String]()
        for element in array {
            let splitElement = element.split(separator: ":")
            dictionary[String(splitElement[0])] = String(splitElement[1])
        }
        return dictionary
    }
    
    func toDouble(string: String) -> Double {
        return NumberFormatter().number(from: string)!.doubleValue
    }
}




