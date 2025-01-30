//
//  NavigationRoute.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/25/25.
//

import Foundation

enum NavigationRoute: Hashable {
    case add(AddRoute)
    
    enum AddRoute: Hashable {
        case timer(Task)
        case congratulations(Task)
    }
}
