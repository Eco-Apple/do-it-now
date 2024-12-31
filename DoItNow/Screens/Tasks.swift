//
//  List.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 12/30/24.
//

import SwiftUI

struct Tasks: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("Recents")
                            .foregroundStyle(.recents)
                            .font(.custom("Manjari-Regular", size: 14))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(.filter)
                        }
                    }
                    .padding(.top, 96)
                    .padding(.bottom, 7)
                    .padding(.leading, 19)
                    .padding(.trailing, 21)
                    
                    VStack {
                        ForEach(0..<200) { _ in
                            NavigationLink {
                            } label : {
                                TasksItem()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 19)
                    .padding(.trailing, 21)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("toolbar-logo-3")
                        .padding(.leading, 5.73)
//                        .padding(.bottom, 25)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label : {
                        Image("plus-3")
                            .padding(8)
                            .background {
                                Color.white
                                    .cornerRadius(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.stroke, lineWidth: 1)
                                    }
                            }
                    }
                    .padding(.trailing, 5)
//                    .padding(.bottom, 25)
                }
            }
        }
    }
}

#Preview {
    Tasks()
}
