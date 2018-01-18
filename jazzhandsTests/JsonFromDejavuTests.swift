//
//  JsonFromDejavuTests.swift
//  jazzhandsTests
//
//  Created by Julian Scharf on 18/1/18.
//  Copyright © 2018 Julian Scharf. All rights reserved.
//

import XCTest

class JsonFromDejavuTests: XCTestCase {
    
    func testShouldExtractTimeFromJsonInput() {
        let json = "{\'song_id\': 1, \'song_name\': \'IronMan\', \'file_sha1\': \'B78CDC925EB0804114AAEBA39B09B69688D15F8E\', \'confidence\': 1485, \'offset_seconds\': 420.00254, \'match_time\': 0.6792910099029541, \'offset\': 9044}"
        let payload = DejavuPayload(json: json)
        
    }
    
}
