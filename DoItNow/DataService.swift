//
//  DataService.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import SwiftData
import UIKit

class DataService {
    private let container: ModelContainer
    private let context: ModelContext
   
    private(set) var sort: Sort = .time
    
    enum Response {
        case success(Any), failure(String)
    }
    
    enum Sort {
        case name, time, tags
    }
    
    @MainActor
    static let shared = DataService()
    
    @MainActor
    private init() {
        container = try! ModelContainer(for: Task.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        context = container.mainContext
    }
    
    func getTasks(page: Int, size: Int) -> [Task] {
        do {
            var sortDescriptor = SortDescriptor<Task>(\Task.title)
            
            switch sort {
            case .name:
                sortDescriptor = SortDescriptor<Task>(\Task.title)
            case .tags:
                sortDescriptor = SortDescriptor<Task>(\Task.tags, order: .reverse)
            case .time:
                sortDescriptor = SortDescriptor<Task>(\Task.createdDate, order: .reverse)
            }
            
            
            var descriptor = FetchDescriptor<Task>(sortBy: [sortDescriptor])
            
            descriptor.fetchLimit = size
            descriptor.fetchOffset = (page - 1) * size
            
            let tasks = try context.fetch(descriptor)
            debugPrint(tasks.count)
            
            return tasks
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    
    func deleteTask(_ task: Task) -> Response {
        do {
            context.delete(task)
            
            try context.save()
            
            return .success("Task successfully deleted.")
        } catch {
            return .failure(error.localizedDescription)
        }
    }
    
    func addTask(_ task: Task) -> Response {
        do {
            context.insert(task)
            debugPrint(task)
            try context.save()
            
            return .success(task)
        } catch {
            return .failure(error.localizedDescription)
        }
    }
    
    func sortTasks(_ sort: Sort, page: Int, size: Int) -> [Task] {
        self.sort = sort
        
        return getTasks(page: page, size: size)
    }
}
