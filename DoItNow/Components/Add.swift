//
//  Add.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/10/25.
//

import SwiftUI

struct Add: View {
    @Environment(\.navigate) var navigate
    
    @State var viewModel: ViewModel
    
    init(callback: @escaping (Task) -> Void) {
        _viewModel = State(initialValue: .init(callback: callback))
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom) {
                    TextField("Run after work!", text: $viewModel.title)
                        .frame(height: 23)
                        .font(.custom("Manjari-Bold", size: 20))
                    
                    Spacer()
                    
                    Text("\(viewModel.title.count)/\(viewModel.titleLimit)")
                        .frame(height: 14)
                        .font(.custom("Manjari-Bold", size: 12))
                        .padding(.bottom, 1)
                        .onChange(of: viewModel.title, viewModel.limitTitle)
                }
                .padding(.leading, 22)
                .padding(.trailing, 21)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .frame(width: 159, height: 1)
                    .padding(.top, 4)
                
                TextEditor(text: $viewModel.description)
                    .placeHolder("Make sure that it is long and slow, don’t make it fast because it will only worsen my prgress, slow but surely", text: $viewModel.description)
                    .frame(height: 160.0)
                    .padding(.leading, 23)
                    .padding(.trailing, 18)
                    .padding(.top, 11)
                    .font(.custom("Manjari-Bold", size: 16))
                
                HStack {
                    Spacer()
                    
                    Text("\(viewModel.description.count)/\(viewModel.descriptionLimit)")
                        .frame(height: 14)
                        .font(.custom("Manjari-Bold", size: 12))
                        .padding(.bottom, 4)
                        .onChange(of: viewModel.description, viewModel.limitDescription)
                }
                .padding(.trailing, 21)
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Divider()
                            .frame(width: 73.21, height: 1)
                    }
                }
                
                Tags(text: $viewModel.tags, tagsLimit: viewModel.tagsLimit)
                
                HStack {
                    Spacer()
                    
                    Text("\(viewModel.tags.count)/\(viewModel.tagsLimit)")
                        .frame(height: 14)
                        .font(.custom("Manjari-Bold", size: 12))
                }
                .padding(.trailing, 20)
                .padding(.top, 11)
                
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.startTimer()
                    } label: {
                        HStack(alignment: .center, spacing: 0){
                            Text("Start")
                                .font(.custom("Manjari-Bold", size: 16))
                                .padding(.top, 5)
                            
                            Image("chevron-right")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(height: 20)
                .padding(.trailing, 16)
                .padding(.top, 26)
                
                Spacer()
                
            }
            .padding(.top, 57.0)
            .padding(.bottom, 31.0)
            .frame(height: 407)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(.rect(topLeadingRadius: 37, topTrailingRadius: 37))
            .shadow(color: .black.opacity(0.25), radius: 23.6, x: -4, y: 1)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    Add { _ in
        
    }
}
