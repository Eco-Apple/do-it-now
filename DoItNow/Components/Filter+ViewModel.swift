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
        private(set) var callback: (OverlayObservable.Action) -> Void
        
        init(cgPoint: CGPoint, callback: @escaping (OverlayObservable.Action) -> Void) {
            self.cgPoint = cgPoint
            self.callback = callback
        }
        
        func sortTapped(_ sort: DataService.Sort, overlayObservable: OverlayObservable) {
            callback(.success(sort))
            overlayObservable.close()
        }
    }
}
