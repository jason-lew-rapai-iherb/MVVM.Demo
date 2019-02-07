//
//  LaunchScreenViewModel.swift
//  MVVM.Demo
//
//  Created by Jason Lew-Rapai on 4/19/18.
//  Copyright © 2018 Jason Lew-Rapai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol LaunchScreenViewModelDelegate: class {
    func launchScreenViewModelDidLaunchLogIn(_ source: LaunchScreenViewModel)
    func launchScreenViewModelDidLaunchParty(_ source: LaunchScreenViewModel)
}

class LaunchScreenViewModel {
    private let userService: UserServiceProtocol
    private let partyService: PartyServiceProtocol
    
    private(set) weak var delegate: LaunchScreenViewModelDelegate?
    
    let logInButtonText: Driver<String>
    
    init(userService: UserServiceProtocol, partyService: PartyServiceProtocol) {
        self.userService = userService
        self.partyService = partyService
        
        let userName: Observable<String> = self.userService.userName.asObservable()
            .map { $0 ?? String.empty }
        
        self.logInButtonText = Observable.combineLatest(
            userName,
            self.userService.isLoggedIn.asObservable())
            .map { userName, isLoggedIn in
                return isLoggedIn
                    ? "Faux Log Out \(userName)"
                    : "Faux Login"
            }
            .asDriver(onErrorJustReturn: String.empty)
    }
    
    func setup(delegate: LaunchScreenViewModelDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    func logInOutButtonTapped() {
        if self.userService.isLoggedIn.value {
            logUserOut()
        } else {
            launchLogIn()
        }
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
