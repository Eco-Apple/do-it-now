//
//  Add+ViewModel.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import SwiftUI

extension Add {
    
    enum Mode {
        case doItNow
        case doItLater
    }
    
    @Observable
    class ViewModel {
        var title: String = ""
        var description: String = ""
        var tags: String = ""
        
        let titleLimit: Int = 23
        let descriptionLimit: Int = 300
        let tagsLimit: Int = 36
        
        var isTimerScreenActive = false
        var isBottomSheetShow = false
        
        var isCanProceed: Bool {
            !title.isEmpty && !description.isEmpty && !tags.isEmpty
        }
        
        private(set) var callback: (Task, Mode) -> Void
        
        init(callback: @escaping (Task, Mode) -> Void){
            self.callback = callback
        }
        
        func isStartEnable() -> Bool {
            guard !title.isEmpty && !description.isEmpty && !tags.isEmpty else { return false }
            
            return true
        }
        
        func doItLater() {
            let task = Task(
                title: title,
                desc: description,
                tags: tags
            )
            
            callback(task, .doItLater)
        }
        
        func startTimer() {
            let task = Task(
                title: title,
                desc: description,
                tags: tags
            )
            
            callback(task, .doItNow)
        }
        
        func limitTitle<V>(oldValue: V, newValue: V) {
            if title.count > titleLimit {
                title = String(title.prefix(titleLimit))
            }
        }
        
        func limitDescription<V>(oldValue: V, newValue: V) {
            if description.count > descriptionLimit {
                description = String(description.prefix(descriptionLimit))
            }
        }
   }
}
