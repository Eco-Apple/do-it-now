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
    var createdAdd: Date
    var updatedAdd: Date
    
    init(title: String, desc: String, tags: String) {
        self.title = title
        self.desc = desc
        self.tags = tags
        self.createdAdd = .now
        self.updatedAdd = .now
    }
}
