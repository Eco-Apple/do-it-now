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
        private(set) var task: Task
        private(set) var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        private var saveTime: Date = .now
        
        var illustration: String
        var isAlertPresented = false
        
        var secondsSinceTheLastSaveTime: Double {
            Date().timeIntervalSince(saveTime)
        }
        
        init(task: Task) {
            self.task = task
            self.illustration = String(Int.random(in: 1...8))
        }
        
        func scene(_ scenePhase: ScenePhase) {
            if scenePhase == .active {
                task.timeElapsed += secondsSinceTheLastSaveTime
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            } else if scenePhase == .background {
                timer.upstream.connect().cancel()
                saveTime = .now
            }
        }
        
        func done(navigate: NavigationAction, dismiss: DismissAction) {
            isAlertPresented = false
            timer.upstream.connect().cancel()
            navigate(.add(.congratulations), isReplace: true)
        }
        
        func pauseTimer() {
            timer.upstream.connect().cancel()
        }
        
        func resumeTimer() {
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
        
        func onReceiveTimer(_ value: Date) {
            task.timeElapsed += 1
        }
        
        func formatTime() -> String {
            let minutes = Int(task.timeElapsed) / 60
            let seconds = Int(task.timeElapsed) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
