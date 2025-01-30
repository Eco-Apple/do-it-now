//
//  Overlay.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/1/25.
//

import SwiftUI

struct CustomAlertModifier<AlertContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var isOverlayShow: Bool
    @Binding var isCloseShow: Bool
    
    
    let alertContent: () -> AlertContent
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                Color
                    .overlay
                    .ignoresSafeArea()
                    .opacity(isOverlayShow ? 1 : 0)
                
                VStack {
                    Spacer()
                }
                .customToolbar {
                    HStack(spacing: .zero) {
                        Image("logo")
                            .resizable()
                            .frame(width: 36.27, height: 39)
                        
                        Spacer()
                        
                        Button {
                            isPresented = false
                        } label: {
                            VStack {
                                Image("x")
                            }
                            .frame(width: 31, height: 31)
                            .background {
                                Color.white
                                    .cornerRadius(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.stroke, lineWidth: 1)
                                    }
                            }
                        }
                        .opacity(isCloseShow ? 1 : 0)
                    }
                    .padding(.leading, 23.73)
                    .padding(.trailing, 24)
                    .padding(.bottom, 15)
                }
                alertContent()
            }
        }
    }
}

extension View {
    func customAlert<Content: View>(isPresented: Binding<Bool>, isOverlayShow: Binding<Bool> = .constant(true), isCloseShow: Binding<Bool> = .constant(true), @ViewBuilder content: @escaping () -> Content) -> some View {
        return modifier(CustomAlertModifier(isPresented: isPresented, isOverlayShow: isOverlayShow, isCloseShow: isCloseShow, alertContent: content))
    }
}
