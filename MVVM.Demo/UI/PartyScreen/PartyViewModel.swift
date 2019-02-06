//
//  PartyViewModel.swift
//  MVVM.Demo
//
//  Created by Jason Lew-Rapai on 4/20/18.
//  Copyright © 2018 Jason Lew-Rapai. All rights reserved.
//

import UIKit

class PartyViewModel {
    var userName: ReadOnlyBehaviorRelay<String?> { return self.userService.userName }
    
    private let userService: UserServiceProtocol
    private let partyService: PartyServiceProtocol
    
    init(userService: UserServiceProtocol, partyService: PartyServiceProtocol) {
        self.userService = userService
        self.partyService = partyService
    }
    
    func getNextColor() -> UIColor {
        return self.partyService.getNextColor()
    }
    
    func getRandomEmoji() -> String {
        return self.partyService.getRandomEmoji()
    }
}
