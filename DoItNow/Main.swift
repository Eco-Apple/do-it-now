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
            
            Navigation {
                Tasks()
            }
            
            if isSplashActive {
                Splash()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isSplashActive = false
            }
        }
    }
}

#Preview {
    Main()
}
