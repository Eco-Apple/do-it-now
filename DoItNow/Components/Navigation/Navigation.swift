//
//  Navigation.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/25/25.
//

import SwiftUI

struct NavigationAction {
    typealias Action = (NavigationRoute, Bool) -> ()
    let action: Action
    func callAsFunction(_ route: NavigationRoute, isReplace: Bool = false) {
        action(route, isReplace)
    }
}

struct NavigationEnvironmentKey: EnvironmentKey {
    static var defaultValue: NavigationAction = NavigationAction(action: { _,_ in })
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
        .environment(\.navigate, NavigationAction(action: { route, isReplace in
            if !isReplace {
                router.path.append(route)
            } else {
                router.path.removeLast()
                router.path.append(route)
            }
        }))
        
    }
}
