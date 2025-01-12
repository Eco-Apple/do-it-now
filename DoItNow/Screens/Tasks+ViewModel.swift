//
//  Tasks+ViewModel.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import Foundation
import SwiftUI

extension Tasks {
    @Observable
    class ViewModel {
        var tasks: [Task]
        
        private var dataService: DataService
        private var page: Int = 1
        private var size: Int = 50
        var isNextPage: Bool = true
        
        init(dataService: DataService) {
            self.dataService = dataService
            
            tasks = dataService.getTasks(page: 1, size: 50)
        }
        
        func add(overlayObservable: OverlayObservable) {
            overlayObservable.present(this: .add) { action in
                switch action {
                case .success(let data):
                    self.tasks.insert(data as! Task, at: 0)
                case .failure(let message):
                    fatalError(message)
                case .cancel: break
                }
            }
        }
        
        func loadNextPage() {
            if isNextPage {
                page = page + 1
                let nextTasks = dataService.getTasks(page: page, size: size)
                if nextTasks.isEmpty {
                    isNextPage = false
                    page = page - 1
                    return
                }
                tasks.append(contentsOf: nextTasks)
            }
        }
    }
}
