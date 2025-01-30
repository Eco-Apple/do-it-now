//
//  NoTasks.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/30/25.
//

import SwiftUI

struct NoTasks: View {
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            Image(.noTasks)
            
            Text("No tasks available")
                .font(.custom("Manjari-Bold", size: 25))
                .padding(.top, -24)
            
            Text("To add new task tap the \"+\"")
                .font(.custom("Manjari-Regular", size: 18))
                .padding(.top, 2)
        }
    }
}

#Preview {
    NoTasks()
}
