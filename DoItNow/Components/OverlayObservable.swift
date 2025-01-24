//
//  OverlayEnvObj.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import SwiftUI

@Observable
class OverlayObservable {
    
    private(set) var isPresented: Bool = false
    private(set) var type: OverlayType = .none
    private(set) var callback: (Action) -> Void = { _ in }
    
    enum OverlayType {
        case none, add, detail, filter(CGPoint), alert(AnyView)
    }
    
    enum Action {
        case cancel, success(Any), failure(String)
    }
    
    func present(this type: OverlayType, callback: @escaping (Action) -> Void) {
        self.isPresented = true
        self.type = type
        self.callback = callback
    }
    
    func close() {
        self.isPresented = false
        self.type = .none
    }
}
