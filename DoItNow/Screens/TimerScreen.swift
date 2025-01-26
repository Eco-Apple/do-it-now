//
//  Timer.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/18/25.
//

import SwiftUI

struct TimerScreen: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel: ViewModel
    
    init(task: Task) {
        _viewModel = State(initialValue: .init(task: task))
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            Image(.yoga)
                .frame(width: 362, height: 362)
                .padding(.top, 164)
            
            Text(viewModel.formatTime())
                .frame(width: 362, height: 70, alignment: .top)
                .font(.custom("Manjari-Bold", size: 95))
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
        .navigationBarBackButtonHidden()
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image("toolbar-logo")
                    .padding(.leading, 5.73)
            }
        }
        .onAppear(perform: viewModel.onAppear)
        .customAlert(isPresented: $viewModel.isAlertPresented) {
            CustomAlert {
                Text("Are you sure")
                    .font(.custom("Manjari-Bold", size: 30))
            } message: {
                Text("You want to finish ")
                    .font(.custom("Manjari-Regular", size: 18))
                + Text(viewModel.task.title)
                    .font(.custom("Manjari-Bold", size: 18))
                + Text("?")
                    .font(.custom("Manjari-Regular", size: 18))
            } actions : {
                HStack(alignment: .center, spacing: .zero){
                    Button {
                        viewModel.done(dismiss: dismiss)
                    } label: {
                        Text("Yes")
                            .frame(maxWidth: .infinity)
                            .font(.custom("Manjari-Bold", size: 20))
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        viewModel.isAlertPresented = false
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
