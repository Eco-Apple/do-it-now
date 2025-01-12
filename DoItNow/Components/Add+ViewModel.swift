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
        
        private let dataService: DataService
        private(set) var callback: (OverlayObservable.Action) -> Void
        
        init(dataService: DataService, callback: @escaping (OverlayObservable.Action) -> Void){
            self.dataService = dataService
            self.callback = callback
        }
        
        func startTimer(overlayObservable: OverlayObservable) {
            let task = Task(
                title: title,
                desc: description,
                tags: tags
            )
            
            let response = dataService.addTask(task)
           
            switch response {
            case .success(let data):
                callback(.success(data))
                overlayObservable.close()
            case .failure(let message): break
            }
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
