//
//  ContentView.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 12/29/24.
//

import SwiftUI

struct Main: View {
    @State var isSplashActive: Bool = true
    
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            if isSplashActive {
                Splash()
                    .ignoresSafeArea()
            } else {
                NavigationStack {
                    Overlay {
                        Tasks()
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    isSplashActive = false
                }
            }
        }
    }
}

#Preview {
    Main()
}
