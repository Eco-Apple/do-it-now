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
    
    enum Response {
        case success(Any), failure(String)
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
            var descriptor = FetchDescriptor<Task>(sortBy: [SortDescriptor<Task>(\Task.createdDate, order: .reverse)])
            
            descriptor.fetchLimit = size
            descriptor.fetchOffset = (page - 1) * size
            
            let tasks = try context.fetch(descriptor)
            debugPrint(tasks.count)
            
            return tasks
        } catch {
            fatalError(error.localizedDescription)
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
}
