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
    private let userService: UserService
    
    let userName: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let password: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let canLogIn: Observable<Bool>
    
    init(userService: UserService) {
        self.userService = userService
        
        self.canLogIn = Observable.combineLatest(
            self.userName.asObservable(),
            self.password.asObservable()) { (userName, password) in
                guard let userName = userName, let password = password else { return false }
                return userName.count > 0 && password.count > 0
            }
    }
    
    func submitLoginInformation() {
        self.userService.userName.accept(self.userName.value)
        self.userService.password.accept(self.password.value)
    }
}
