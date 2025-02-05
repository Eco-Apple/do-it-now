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
        var sortButtonPosition: CGPoint = .zero
        
        var isAddPresented = false
        var isSortPresented = false
        var isDetailPresented = false
        var taskSelected: Task? = nil
        
        var isAddButtonShow = false
        var isRecentShow = false
        var isSortButtonShow = false
        var isAddBSOverlayShow = false
        var isNoTaskShow = false
        var isTasksShow = false
        
        init(dataService: DataService) {
            self.dataService = dataService
            
            tasks = dataService.getTasks(page: 1, size: 50)
        }
        
        func sortCallback(sort: DataService.Sort) {
            reset()
            tasks = dataService.sortTasks(sort, page: page, size: size)
            isSortPresented = false
        }
        
        func sort() {
            isSortPresented = true
        }
        
        func addCallback(task: Task, mode: Add.Mode, navigate: NavigationAction) {
            let response = dataService.addTask(task)
            
            switch response {
            case .success(let data):
                guard let task = data as? Task else { return }
                
                if mode == .doItNow {
                    tasks.insert(task, at: 0)
                    navigate(.add(.timer(task)))
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.isAddPresented = false
                    }
                } else if mode == .doItLater {
                    tasks.insert(task, at: 0)
                    self.isAddPresented = false
                }
                
            case .failure(let message):
                fatalError(message)
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
        
        func reset() {
            page = 1
            size = 50
            isNextPage = true
        }
    }
}
