//
//  TimerScreen+ViewModel.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/24/25.
//

import SwiftUI

extension TimerScreen {
    @Observable
    class ViewModel {
        var timeElapsed: Double = 0.0
        
        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        func onAppear() {
            timeElapsed = 0.0
        }
        
        func done(dismiss: DismissAction, overlayObservable: OverlayObservable) {
            overlayObservable.present(this: .alert(AnyView(Text("Test")))) { _ in
                
            }
//            timer.upstream.connect().cancel()
//            dismiss()
        }
        
        func onReceiveTimer(_ value: Date) {
            timeElapsed += 1
        }
        
        func formatTime() -> String {
            let minutes = Int(timeElapsed) / 60
            let seconds = Int(timeElapsed) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
