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
    var timeStarted: Date?
    
    var createdDate: Date
    var updatedDate: Date
    
    init(title: String, desc: String, tags: String) {
        self.title = title
        self.desc = desc
        self.tags = tags
        self.createdDate = .now
        self.updatedDate = .now
    }
}


extension Task {
    static var example = Task(title: "Example Task", desc: "This is an example task", tags: "example")
}
