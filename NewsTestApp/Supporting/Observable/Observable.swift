//
//  Observable.swift
//  NewsTestApp
//
//  Created by MacBook Pro on 02.08.22.
//

import Foundation


final class Observable<T> {
    
    public typealias Observer = ((T?) -> Void)?
    private var observers: [Observer]
    
    var value: T? {
        didSet {
            notifyObservers(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
        observers = []
    }

    
    func bind(observer: Observer) {
        self.observers.append(observer)
    }
    
    private func notifyObservers(_ value: T?) {
        self.observers.forEach { (observer) in
            observer!(value)
        }
    }
}


protocol Weakifiable: AnyObject {}

extension Weakifiable {
    func weaky<T>(_ code: @escaping (Self, T) -> Void) -> (T) -> Void {
        return { [weak self] data in
            guard let self = self else { return }
            code(self, data)
        }
    }
}

extension NSObject: Weakifiable {}
