//
//  Timer.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/18/25.
//

import SwiftUI

struct TimerScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.navigate) var navigate
    
    @State private var viewModel: ViewModel
    
    init(task: Task) {
        _viewModel = State(initialValue: .init(task: task))
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Image(viewModel.illustration)
                .frame(width: 362, height: 362)
                .padding(.top, 62)
            
            Text(viewModel.formatTime())
                .frame(width: 362, height: 70, alignment: .top)
                .font(.custom("Manjari-Bold", size: viewModel.isHourPassed ? 80 : 95))
                .padding(.top, -2)
                .onReceive(viewModel.timer, perform: viewModel.onReceiveTimer)
            
            Text(viewModel.task.title)
                .frame(width: 362, height: 19, alignment: .top)
                .font(.custom("Manjari-Bold", size: 20))
                .padding(.top, 19)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    viewModel.isAlertPresented = true
                    viewModel.pauseTimer()
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
        }
        .navigationBarBackButtonHidden()
        .background(Color("Background"))
        .customToolbar {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 36.27, height: 39)
                Spacer()
            }
            .padding(.leading, 23.73)
            .padding(.trailing, 24)
            .background(Color("Background"))
        }
        .onChange(of: scenePhase) {
            viewModel.scene(scenePhase)
        }
        .customAlert(isPresented: $viewModel.isAlertPresented) {
            CustomAlert {
                Text("Are you sure")
                    .font(.custom("Manjari-Bold", size: 30))
            } message: {
                Text("You want to finish ")
                    .font(.custom("Manjari-Regular", size: 18))
                + Text(viewModel.task.title)
                    .font(.custom("Manjari-Bold", size: 18))
                + Text(" at ")
                    .font(.custom("Manjari-Regular", size: 18))
                + Text(viewModel.task.timeElapsedFormatted)
                    .font(.custom("Manjari-Bold", size: 18))
                + Text("?")
                    .font(.custom("Manjari-Regular", size: 18))
            } actions : {
                HStack(alignment: .center, spacing: .zero){
                    Button {
                        viewModel.done(navigate: navigate, dismiss: dismiss)
                    } label: {
                        Text("Yes")
                            .frame(maxWidth: .infinity)
                            .font(.custom("Manjari-Bold", size: 20))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        viewModel.isAlertPresented = false
                        viewModel.resumeTimer()
                    } label: {
                        Text("No")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.black.opacity(0.5))
                            .font(.custom("Manjari-Bold", size: 20))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

#Preview {
    TimerScreen(task: .example)
}
