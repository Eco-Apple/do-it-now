//
//  Add+ViewModel.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import SwiftUI

extension Detail {
    enum Mode {
        case delete
        case start
    }
    enum Response {
        case success(String, Mode)
        case failure(String)
    }
    
    @Observable
    class ViewModel {
        
        var task: Task
        
        let titleLimit: Int = 23
        let descriptionLimit: Int = 300
        let tagsLimit: Int = 36
        
        var isAlertPresented = false
        var isBottomSheetShow = false
        
        private let dataService: DataService
        
        private(set) var isDetailPresented: Binding<Bool>
        private(set) var callback: (Detail.Response) -> Void
        
        init(dataService: DataService, task: Task, isDetailPresented: Binding<Bool>, callback: @escaping (Detail.Response) -> Void){
            self.dataService = dataService
            self.task = task
            self.isDetailPresented = isDetailPresented
            self.callback = callback
        }
        
        func startTimer() {
            callback(.success("Successfully start task", .start))
        }
        
        func deleteTask() {
            let response = dataService.deleteTask(task)
            
            switch response {
            case .success(let message):
                isDetailPresented.wrappedValue = false
                callback(.success("Successfully deleted task", .delete))
            case .failure(let message):
                fatalError(message)
            }
        }
        
        func limitTitle<V>(oldValue: V, newValue: V) {
            if task.title.count > titleLimit {
                task.title = String(task.title.prefix(titleLimit))
            }
        }
        
        func limitDescription<V>(oldValue: V, newValue: V) {
            if task.desc.count > descriptionLimit {
                task.desc = String(task.desc.prefix(descriptionLimit))
            }
        }
        
        func limitTags<V>(oldValue: V, newValue: V) {
            if task.tags.count > tagsLimit {
                task.tags = String(task.tags.prefix(tagsLimit))
            }
        }
    }
    
}
