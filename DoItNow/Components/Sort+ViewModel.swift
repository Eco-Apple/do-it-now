//
//  Filter+ViewModel.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/13/25.
//

import SwiftUI

extension Sort {
    @Observable
    class ViewModel {
        private(set) var cgPoint: CGPoint
        private(set) var callback: (DataService.Sort) -> Void
        
        init(cgPoint: CGPoint, callback: @escaping (DataService.Sort) -> Void) {
            self.cgPoint = cgPoint
            self.callback = callback
        }
        
        func sortTapped(_ sort: DataService.Sort) {
            callback(sort)
        }
    }
}
