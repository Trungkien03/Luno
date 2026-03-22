//
//  Observers.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 22/3/26.
//

import Foundation


final class Observable<T> {
    
    /// closure execute when value changed
    typealias Observer = (T) -> Void
    
    private var observers: [UUID: Observer] = [:]
    
    /// main value
    var value : T {
        didSet {
           notifyObservers()
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    /// Sign observer and return one ID for discard later
    @discardableResult
    func observe(_ observer: @escaping Observer) -> UUID {
        let id = UUID()
        observers[id] = observer
        /// run first time -> to udpate initial UI
        observer(value)
        return id
    }
    
    func remove(identifier: UUID) {
        observers.removeValue(forKey: identifier)
    }
    
    private func notifyObservers() {
        observers.values.forEach { $0(value) }
    }
}
