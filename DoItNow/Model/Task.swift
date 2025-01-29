//
//  Task.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/11/25.
//

import Foundation
import SwiftData

@Model
class Task: Identifiable {
    var title: String
    var desc: String
    var tags: String
    var timeElapsed: Double
    
    var createdDate: Date
    var updatedDate: Date
    
    var timeElapsedFormatted: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .hour, .day, .second]
        formatter.unitsStyle = .full
        
        return formatter.string(from: timeElapsed) ?? "Just now"
    }
    
    init(title: String, desc: String, tags: String) {
        self.title = title
        self.desc = desc
        self.tags = tags
        self.timeElapsed = 0.0
        self.createdDate = .now
        self.updatedDate = .now
    }
}


extension Task {
    static var example = Task(title: "Example Task", desc: "This is an example task", tags: "example")
}
