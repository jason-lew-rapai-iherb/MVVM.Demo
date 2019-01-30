//
//  UserService.swift
//  MVVM.Demo
//
//  Created by Jason Lew-Rapai on 4/19/18.
//  Copyright © 2018 Jason Lew-Rapai. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserService {
    let userName: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let password: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    
    private let _isLoggedIn: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    let isLoggedIn: ReadOnlyBehaviorRelay<Bool>
    
    private let disposeBag: DisposeBag
    
    init() {
        self.isLoggedIn = ReadOnlyBehaviorRelay(self._isLoggedIn)
        
        self.disposeBag = DisposeBag()
        
        Observable.combineLatest(
            self.userName.asObservable(),
            self.password.asObservable())
            .subscribe(onNext: { [weak self] (userName, password) in
                if let userName = userName, let password = password {
                    self?._isLoggedIn.accept(!userName.isEmpty && !password.isEmpty)
                } else {
                    self?._isLoggedIn.accept(false)
                }
            }).disposed(by: self.disposeBag)
    }
}
