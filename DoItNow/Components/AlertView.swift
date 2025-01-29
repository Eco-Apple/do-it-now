//
//  AlertView.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/24/25.
//

import SwiftUI

struct CustomAlert<Title: View, Message: View, Actions: View>: View {
    
    let title: () -> Title
    let message: () -> Message
    let actions: () -> Actions
    
    init(@ViewBuilder title: @escaping () -> Title, @ViewBuilder message: @escaping () -> Message, @ViewBuilder actions: @escaping () -> Actions) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            title()
            
            message()
                .padding(.top, 10)
            
            actions()
                .padding(.top, 43)
        }
        .padding(.top, 26)
        .padding(.bottom, 20)
        .frame(width: 362)
        .frame(minHeight: 163, alignment: .top)
        .background(.white)
        .cornerRadius(28)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 1)
    }
}

#Preview {
    CustomAlert {
        Text("Are you sure")
            .font(.custom("Manjari-Bold", size: 30))
    } message: {
        Text("You want to finish Run After Work?")
            .font(.custom("Manjari-Regular", size: 18))
    } actions : {
        HStack(alignment: .center, spacing: .zero){
            Text("Yes")
                .frame(maxWidth: .infinity)
                .font(.custom("Manjari-Bold", size: 20))
            
            Text("No")
                .frame(maxWidth: .infinity)
                .foregroundStyle(.black.opacity(0.5))
                .font(.custom("Manjari-Bold", size: 20))
        }
    }
}
