//
//  Splash.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 12/30/24.
//

import SwiftUI

struct Splash: View {
    @State private var isShowing = false
    @State private var isMoving = false
    
    var body: some View {
        ZStack {
            Color
                .clear
                .contentShape(Rectangle())
                .allowsHitTesting(true)
            
            VStack(alignment: .leading, spacing: .zero) {
                VStack(alignment: .leading, spacing: .zero){
                    HStack(spacing: .zero) {
                        Image("logo")
                            .resizable()
                            .frame(width: !isMoving ? 200 : 36.27, height: !isMoving ? 200 : 39)
                            .opacity(isShowing ? 1: 0)
                        
                        if isMoving {
                            Spacer()
                        }
                    }
                    .padding(.leading, 23.73)
                    .padding(.trailing, 24)
                    .padding(.bottom, 15)
                }
                
                if isMoving {
                    Spacer()
                }
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)){
                isShowing = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeInOut(duration: 1.5)) {
                    isMoving = true
                }
            }
        }
    }
}

#Preview {
    Splash()
}
