//
//  Overlay.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/1/25.
//

import SwiftUI

struct CustomAlertModifier<AlertContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    
    let alertContent: () -> AlertContent
    
    func body(content: Content) -> some View {
        if isPresented {
            ZStack {
                content
                
                Color
                    .overlay
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isPresented = false
                        } label: {
                            Image("x")
                                .padding(4.9)
                                .background {
                                    Color.white
                                        .cornerRadius(10)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(.stroke, lineWidth: 1)
                                        }
                                }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer()
                }
                
                alertContent()
            }
        } else {
            content
        }
    }
}

extension View {
    func customAlert<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        return modifier(CustomAlertModifier(isPresented: isPresented, alertContent: content))
    }
}
