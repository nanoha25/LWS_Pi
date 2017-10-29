//
//  Accelerator4Tests.swift
//  Accelerator4Tests
//
//  Created by Leo Lee on 30/10/17.
//  Copyright © 2017 Leo Lee. All rights reserved.
//

import XCTest
import CoreData
@testable import Pods_Accelerator4

class Accelerator4Tests: XCTestCase {
    var viewController: ViewController!
 
        override func setUp() {
            super.setUp()
            // Put setup code here. This method is called before the invocation of each test method in the class.
          
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            viewController = storyboard.instantiateInitialViewController() as! ViewController
        }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        func testLabelValueShowedProperly(){
            
            let viewcon = ViewController.view
            
            XCTAssert(viewcon.emailField.text == "dfdfd", "Input valid email plz")
            XCTAssert(viewcon.passwordField.text == "50.0%", "Input valid password with at least 6 characters with more than one alphabet")
           
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
