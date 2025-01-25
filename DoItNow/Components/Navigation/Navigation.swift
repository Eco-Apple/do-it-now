//
//  Navigation.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/25/25.
//

import SwiftUI

struct NavigationAction {
    typealias Action = (NavigationRoute) -> ()
    let action: Action
    func callAsFunction(_ route: NavigationRoute) {
        action(route)
    }
}

struct NavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: NavigationAction = NavigationAction(action: { _ in })
}

extension EnvironmentValues {
    var navigate: (NavigationAction) {
        get {self[NavigationEnvironmentKey.self]}
        set {self[NavigationEnvironmentKey.self] = newValue}
    }
}

struct Navigation<Content: View>: View {
    @Environment(NavigationManager.self) var navigationManager
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        NavigationStack(path: $navigationManager.router.path) {
            content
                .navigationDestination(for: NavigationRoute.self) { route in
                    navigationManager.router.destination(for: route)
                }
        }
    }
}
