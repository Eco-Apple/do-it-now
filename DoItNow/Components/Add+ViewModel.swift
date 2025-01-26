//
//  Add+ViewModel.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import SwiftUI

extension Add {
    @Observable
    class ViewModel {
        var title: String = ""
        var description: String = ""
        var tags: String = ""
        
        let titleLimit: Int = 23
        let descriptionLimit: Int = 300
        let tagsLimit: Int = 36
        
        var isTimerScreenActive = false
        
        private(set) var callback: (Task) -> Void
        
        init(callback: @escaping (Task) -> Void){
            self.callback = callback
        }
        
        func startTimer() {
            let task = Task(
                title: title,
                desc: description,
                tags: tags
            )
            
            callback(task)
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
