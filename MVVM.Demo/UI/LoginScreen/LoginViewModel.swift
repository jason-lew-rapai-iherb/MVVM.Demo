//
//  LoginViewModel.swift
//  MVVM.Demo
//
//  Created by Jason Lew-Rapai on 4/19/18.
//  Copyright © 2018 Jason Lew-Rapai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    private let userService: UserServiceProtocol
    
    let userName: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let password: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let canLogIn: Driver<Bool>
    
    init(userService: UserServiceProtocol) {
        self.userService = userService
        
        self.canLogIn = Observable.combineLatest(
            self.userName.asObservable(),
            self.password.asObservable()) { (userName, password) in
                guard let userName = userName, let password = password else { return false }
                return userName.count > 0 && password.count > 0
            }
            .asDriver(onErrorJustReturn: false)
    }
    
    func submitLoginInformation() {
        guard let userName = self.userName.value, let password = self.password.value else { return }
        self.userService.logIn(userName: userName, password: password)
    }
}
