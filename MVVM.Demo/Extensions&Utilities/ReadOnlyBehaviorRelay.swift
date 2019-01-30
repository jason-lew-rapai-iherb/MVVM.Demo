//
//  ReadOnlyBehaviorRelay.swift
//  MVVM.Demo
//
//  Created by Jason Lew-Rapai on 4/20/18.
//  Copyright © 2018 Jason Lew-Rapai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class ReadOnlyBehaviorRelay<Element> {
    public typealias E = Element
    
    private let _relay: BehaviorRelay<Element>
    
    public var value: Element {
        return self._relay.value
    }
    
    public init(_ relay: BehaviorRelay<Element>) {
        self._relay = relay
    }
    
    public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return self._relay.subscribe(observer)
    }
    
    public func asObservable() -> Observable<Element> {
        return self._relay.asObservable()
    }
}
