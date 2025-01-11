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
    
    @MainActor
    static let shared = DataService()
    
    @MainActor
    private init() {
        container = try! ModelContainer(for: Task.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        context = container.mainContext
    }
    
    func getTasks() -> [Task] {
        do {
            let tasks = try context.fetch(FetchDescriptor<Task>())
            
            debugPrint(tasks)
            
            return tasks
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addTask(_ task: Task) {
        do {
            context.insert(task)
            
            debugPrint(task)
            
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
}
