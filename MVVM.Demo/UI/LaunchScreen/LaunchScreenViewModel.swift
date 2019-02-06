//
//  LaunchScreenViewModel.swift
//  MVVM.Demo
//
//  Created by Jason Lew-Rapai on 4/19/18.
//  Copyright © 2018 Jason Lew-Rapai. All rights reserved.
//

import UIKit

protocol LaunchScreenViewModelDelegate: class {
    func launchScreenViewModelDidLaunchLogIn(_ source: LaunchScreenViewModel)
    func launchScreenViewModelDidLaunchParty(_ source: LaunchScreenViewModel)
}

class LaunchScreenViewModel {
    private let userService: UserServiceProtocol
    private let partyService: PartyServiceProtocol
    
    private(set) weak var delegate: LaunchScreenViewModelDelegate?
    
    var userName: ReadOnlyBehaviorRelay<String?> { return self.userService.userName }
    var isUserLoggedIn: ReadOnlyBehaviorRelay<Bool> { return self.userService.isLoggedIn }
    
    init(userService: UserServiceProtocol, partyService: PartyServiceProtocol) {
        self.userService = userService
        self.partyService = partyService
    }
    
    func setup(delegate: LaunchScreenViewModelDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    func logUserOut() {
        self.userService.logOut()
    }
    
    func getNextColor() -> UIColor {
        return self.partyService.getNextColor()
    }
    
    func launchLogIn() {
        self.delegate?.launchScreenViewModelDidLaunchLogIn(self)
    }
    
    func launchParty() {
        self.delegate?.launchScreenViewModelDidLaunchParty(self)
    }
}
