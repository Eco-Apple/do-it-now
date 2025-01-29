//
//  TasksItem.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 12/31/24.
//

import SwiftUI

struct TasksItem: View {
    let task: Task
    
    var body: some View {
        HStack(alignment: .top) {
            Image(task.timeElapsed != 0 ? "check" : "uncheck")
                .alignmentGuide(.top) { d in
                    3
                }
            VStack(alignment: .leading, spacing: 0) {
                Text(task.title)
                    .frame(height: 21)
                    .font(.custom("Manjari-Bold", size: 18))
                Text(task.timeElapsedFormatted)
                    .frame(height: 16)
                    .foregroundStyle(.fontSecondary)
                    .font(.custom("Manjari-Bold", size: 14))
            }
            
            Spacer()
        }
        .frame(height: 36)
        .frame(maxWidth: .infinity)
    }
    
}

#Preview {
    TasksItem(task: .example)
}
