//
//  PartyViewModel+Tests.swift
//  MVVM.DemoTests
//
//  Created by Jason Lew-Rapai on 2/6/19.
//  Copyright © 2019 Jason Lew-Rapai. All rights reserved.
//

import XCTest
@testable import MVVM_Demo

class PartyViewModel_Test: XCTestCase {
    var mockUserService: MockUserService!
    var mockPartyService: MockPartyService!
    var target: PartyViewModel!
    
    override func setUp() {
        super.setUp()
        
        self.mockUserService = MockUserService()
        self.mockPartyService = MockPartyService()
        
        self.target = PartyViewModel(
            userService: self.mockUserService,
            partyService: self.mockPartyService)
    }
}

class PartyViewModel_when_initialized: PartyViewModel_Test {
    func test_userName_is_userService_userName() {
        XCTAssert(self.target.userName === self.mockUserService.userName)
    }
}

class PartyViewModel_when_getNextColor_is_called: PartyViewModel_Test {
    var getNextColorCallCount: Int = 0
    
    override func setUp() {
        super.setUp()
        
        self.mockPartyService.getNextColorTestClosure = {
            self.getNextColorCallCount = self.getNextColorCallCount + 1
        }
        
        let _ = self.target.getNextColor()
    }
    
    func test_then_partyService_getNextColor_is_called_once() {
        XCTAssertEqual(self.getNextColorCallCount, 1)
    }
}

class PartyViewModel_when_getRandomEmoji_is_called: PartyViewModel_Test {
    var getRandomEmojiCallCount: Int = 0
    
    override func setUp() {
        super.setUp()
        
        self.mockPartyService.getRandomEmojiTestClosure = {
            self.getRandomEmojiCallCount = self.getRandomEmojiCallCount + 1
        }
        
        let _ = self.target.getRandomEmoji()
    }
    
    func test_then_partyService_getRandomEmoji_is_called_once() {
        XCTAssertEqual(self.getRandomEmojiCallCount, 1)
    }
}
