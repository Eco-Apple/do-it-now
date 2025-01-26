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
    @State private var router = NavigationRouter()

    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: NavigationRoute.self) { route in
                    router.destination(for: route)
                }
        }
        .environment(\.navigate, NavigationAction(action: { route in
            router.path.append(route)
        }))
        
    }
}
