//
//  NavigationRouter.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/25/25.
//

import SwiftUI

@Observable
class NavigationRouter {
    var path = NavigationPath()
    
    @ViewBuilder
    func destination(for route: NavigationRoute) -> some View {
        switch route {
        case .add(let route):
            handleAddRoutes(route)
        }
    }
    
    @ViewBuilder
    private func handleAddRoutes(_ route: NavigationRoute.AddRoute) -> some View {
        switch route {
        case .timer(let task):
            TimerScreen(task: task)
        }
    }
}
