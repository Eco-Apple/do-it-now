//
//  TasksItem.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 12/31/24.
//

import SwiftUI

struct TasksItem: View {
    @State var isCheckShow = false
    @State var isTitleShow = false
    @State var isTimeShow = false
    @State var isCheck = false
    
    let task: Task
    let index: Int
    
    var onSplashDelay = 0.0
    
    var body: some View {
        HStack(alignment: .top) {
            Image(isCheck ? "check" : "uncheck")
                .alignmentGuide(.top) { d in
                    3
                }
                .opacity(isCheckShow ? 1 : 0)
                .offset(y: isCheckShow ? 0 : 5)
                .animation(.easeInOut(duration: 1).delay(Double(index) * 0.1), value: isCheckShow)
                .animation(.easeInOut(duration: 1).delay(Double(index) * 0.2), value: isCheck)
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text(task.title)
                    .frame(height: 21)
                    .font(.custom("Manjari-Bold", size: 18))
                    .opacity(isTitleShow ? 1 : 0)
                    .offset(x: isTitleShow ? 0 : -5)
                    .animation(.easeInOut(duration: 1).delay(Double(index) * 0.1), value: isTitleShow)
                
                Text(task.timeElapsedFormatted)
                    .frame(height: 16)
                    .foregroundStyle(.fontSecondary)
                    .font(.custom("Manjari-Bold", size: 14))
                    .opacity(isTimeShow ? 1 : 0)
                    .offset(x: isTimeShow ? 0 : -5)
                    .animation(.easeInOut(duration: 1).delay(Double(index) * 0.1), value: isTimeShow)
            }
            
            Spacer()
        }
        .frame(height: 36)
        .frame(maxWidth: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                isCheckShow = true
                isTitleShow = true
                isTimeShow = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if task.timeElapsed != 0 {
                    isCheck = true
                }
            }
        }
    }
    
}

#Preview {
    TasksItem(task: .example, index: 0)
}
