//
//  Add+ViewModel.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import SwiftUI

extension Detail {
    
    @Observable
    class ViewModel {
        var title: String = ""
        var description: String = ""
        var tags: String = ""
        
        let titleLimit: Int = 23
        let descriptionLimit: Int = 300
        let tagsLimit: Int = 36
        
        private let dataService: DataService
        
        init(dataService: DataService){
            self.dataService = dataService
        }
        
        func startTimer() {
            let task = Task(
                title: title,
                desc: description,
                tags: tags
            )
            
//            dataService.addTask(task, callback: { _ in })
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
        
        func limitTags<V>(oldValue: V, newValue: V) {
            if tags.count > tagsLimit {
                tags = String(tags.prefix(tagsLimit))
            }
        }
    }
    
}
