//
//  Timer.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/18/25.
//

import SwiftUI

struct TimerScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(OverlayObservable.self) var overlayObservable
    
    private var viewModel = ViewModel()
    
    var body: some View {
        ZStack {
            Color("Background")
            
            VStack(spacing: .zero) {
                Image(.yoga)
                    .frame(width: 362, height: 362)
                    .padding(.top, 164)
                
                Text(viewModel.formatTime())
                    .frame(width: 362, height: 70, alignment: .top)
                    .font(.custom("Manjari-Bold", size: 95))
                    .padding(.top, -2)
                    .onReceive(viewModel.timer, perform: viewModel.onReceiveTimer)
                
                Text("Run After work!")
                    .frame(width: 362, height: 19, alignment: .top)
                    .font(.custom("Manjari-Bold", size: 20))
                    .padding(.top, 19)
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.done(dismiss: dismiss, overlayObservable: overlayObservable)
                    } label: {
                        HStack(alignment: .top, spacing: 0){
                            Text("Done")
                                .frame(width: 55, height: 12, alignment: .topTrailing)
                                .font(.custom("Manjari-Bold", size: 16))
                                .padding(.top, 3)
                            
                            Image(.chevronRight)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(height: 20)
                .padding(.trailing, 16)
                .padding(.bottom, 31)
            }
            .ignoresSafeArea()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("toolbar-logo")
                        .padding(.leading, 5.73)
                }
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .onAppear(perform: viewModel.onAppear)
    }
}

#Preview {
    TimerScreen()
}
