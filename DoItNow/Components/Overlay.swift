//
//  Overlay.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/1/25.
//

import SwiftUI

struct Overlay<Content: View>: View {
    @State var overlayObservable = OverlayObservable()
    
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            content
            
            if overlayObservable.isPresented {
                Color
                    .overlay
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            overlayObservable.close()
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
               
                if overlayObservable.type == .add {
                    Add()
                }
                
                if overlayObservable.type == .detail {
                    Detail()
                }
            }
        }
        .environment(overlayObservable)
    }
}

#Preview {
    Overlay {
    }
}
