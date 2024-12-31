//
//  TasksItem.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 12/31/24.
//

import SwiftUI

struct TasksItem: View {
    var body: some View {
        HStack(alignment: .top) {
            Image("uncheck")
                .alignmentGuide(.top) { d in
                    3
                }
            VStack(alignment: .leading, spacing: 0) {
                Text("Study computer science.")
                    .frame(height: 21)
                    .font(.custom("Manjari-Bold", size: 18))
                Text("40 mins")
                    .frame(height: 16)
                    .foregroundStyle(.fontSecondary)
                    .font(.custom("Manjari-Bold", size: 14))
            }
        }
        .frame(height: 36)
    }
}

#Preview {
    TasksItem()
}
