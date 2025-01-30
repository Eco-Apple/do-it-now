//
//  Filter.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/13/25.
//

import SwiftUI

struct Sort: View {
    @State var viewModel: ViewModel
    
    init(cgPoint: CGPoint, callback: @escaping (DataService.Sort) -> Void) {
        _viewModel = State(initialValue: .init(cgPoint: cgPoint, callback: callback))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Sort by:")
                .font(.custom("Manjari-Bold", size: 18))
                .frame(height: 21)
                .padding(.horizontal, 13)
                .padding(.top, 16)

            Button {
                viewModel.sortTapped(.name)
            } label: {
                Text("name")
                    .font(.custom("Manjari-Regular", size: 18))
                    .frame(height: 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 7)
                    .padding(.bottom, 3)
                    .padding(.horizontal, 13)
                    .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider()
                .frame(height: 1)
            
            Button {
                viewModel.sortTapped(.time)
            } label: {
                Text("time")
                    .font(.custom("Manjari-Regular", size: 18))
                    .frame(height: 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .padding(.horizontal, 13)
                    .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            
            Divider()
                .frame(height: 1)
            
            Button {
                viewModel.sortTapped(.tags)
            } label: {
                Text("tags")
                    .font(.custom("Manjari-Regular", size: 18))
                    .frame(height: 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 8)
                    .padding(.bottom, 11)
                    .padding(.horizontal, 13)
                    .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 133, height: 140, alignment: .leading)
        .background(.filterBackground)
        .cornerRadius(11)
        .position(x: viewModel.cgPoint.x - 50, y: viewModel.isAnimated ? viewModel.cgPoint.y + 45 : viewModel.cgPoint.y + 45 - 10)
        .opacity(viewModel.isAnimated ? 1 : 0)
        .onAppear {
            viewModel.isAnimated = false
            
            withAnimation(.easeInOut(duration: 0.5)) {
                viewModel.isAnimated = true
            }
        }
    }
}

#Preview {
    Sort(cgPoint: .zero, callback: { _ in })
}
