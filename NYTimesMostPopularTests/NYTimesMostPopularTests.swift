//
//  NYTimesMostPopularTests.swift
//  NYTimesMostPopularTests
//
//  Created by faisal khalid on 7/14/19.
//  Copyright © 2019 faisalkhalid. All rights reserved.
//

import XCTest
@testable import NYTimesMostPopular

class NYTimesMostPopularTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMostPopularService() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var client = NYTimesWebClient()
        client.getMostPopularArticles(section: MostPopularSectionType.allSections.rawValue, noOfDays: 1) {error,articles in
            if let error = error {
                XCTFail("Testing Error : \(error.localizedDescription)")
            }
  
        }

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
