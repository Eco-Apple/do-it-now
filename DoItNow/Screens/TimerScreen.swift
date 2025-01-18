//
//  Timer.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/18/25.
//

import SwiftUI

struct TimerScreen: View {
    var body: some View {
        ZStack {
            Color("Background")
            
            NavigationStack {
                VStack(spacing: .zero) {
                    Image(.yoga)
                        .frame(width: 362, height: 362)
                        .padding(.top, 164)
                    Text("00:20")
                        .frame(width: 362, height: 70, alignment: .top)
                        .font(.custom("Manjari-Bold", size: 95))
                        .padding(.top, -2)
                    Text("Run After work!")
                        .frame(width: 362, height: 19, alignment: .top)
                        .font(.custom("Manjari-Bold", size: 20))
                        .padding(.top, 19)
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
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
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TimerScreen()
}
