//
//  PartyViewModel.swift
//  MVVM.Demo
//
//  Created by Jason Lew-Rapai on 4/20/18.
//  Copyright © 2018 Jason Lew-Rapai. All rights reserved.
//

import UIKit

class PartyViewModel {
    var userName: ReadOnlyBehaviorRelay<String?>
    
    private let userService: UserService
    private let partyService: PartyService
    
    init(userService: UserService, partyService: PartyService) {
        self.userService = userService
        self.partyService = partyService
        
        self.userName = ReadOnlyBehaviorRelay(self.userService.userName)
    }
    
    func getNextColor() -> UIColor {
        return self.partyService.getNextColor()
    }
    
    func getRandomEmoji() -> String {
        return self.partyService.getRandomEmoji()
    }
}
