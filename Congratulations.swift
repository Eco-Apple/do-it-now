//
//  Congratulations.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/30/25.
//

import ConfettiSwiftUI
import SwiftUI

struct Congratulations: View {
    @Environment(\.dismiss) var dismiss
    
    @State var triggerConfetti = false
    
    var body: some View {
        ZStack {
           
            VStack(spacing: .zero) {
                Image(.congrats)
                    .frame(width: 358, height: 358)
                    
                
                
                VStack(spacing: .zero) {
                    Text("Yeheey  🎉🎉🎉")
                        .font(.custom("Manjari-Bold", size: 25))
                        .confettiCannon(trigger: $triggerConfetti, num: 40, radius: 450)
                    
                    VStack(spacing: 0){
                        Text("Congratulations for finishing ")
                            .font(.custom("Manjari-Regular", size: 18))
                        + Text("Run after work")
                            .font(.custom("Manjari-Bold", size: 18))
                        + Text(" at ")
                            .font(.custom("Manjari-Regular", size: 18))
                        + Text("40 minutes")
                            .font(.custom("Manjari-Bold", size: 18))
                    }
                    .padding(.top, 6)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 25)
                .padding(.top, -25)
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .frame(maxWidth: .infinity)
            .background(Color("Background"))
            .onAppear {
                triggerConfetti.toggle()
            }
            .customToolbar {
                HStack {
                    Image("logo")
                        .resizable()
                        .frame(width: 36.27, height: 39)
                    Spacer()
                    Spacer()
                    Button {
                        dismiss()
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
                .padding(.leading, 23.73)
                .padding(.trailing, 24)
                .background(Color("Background"))
            }
        }
    }
}

#Preview {
    Congratulations()
}
