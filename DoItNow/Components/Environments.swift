//
//  Environments.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/25/25.
//

import SwiftUI

struct Environments<Content: View>: View {
    @State private var navigationManager = NavigationManager()
    @State var overlayObservable = OverlayObservable()

    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .environment(navigationManager)
            .environment(overlayObservable)
            .environment(\.navigate, NavigationAction(action: { route in
                navigationManager.router.path.append(route)
            }))
    }
}

@Observable
class NavigationManager {
    var router = NavigationRouter()
}
