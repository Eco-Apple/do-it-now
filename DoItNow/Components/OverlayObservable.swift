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
    
    enum OverlayType {
        case none, add, detail
    }
    
    func present(this type: OverlayType) {
        self.isPresented = true
        self.type = type
    }
    
    func close() {
        self.isPresented = false
        self.type = .none
    }
}
