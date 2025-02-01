//
//  Add.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 1/10/25.
//

import SwiftUI

struct Detail: View {
    
    @State var viewModel: ViewModel
    
    init(task: Task, isDetailPresented: Binding<Bool>, callback: @escaping (Detail.Response) -> Void) {
        _viewModel = State(initialValue: .init(dataService: .shared, task: task, isDetailPresented: isDetailPresented, callback: callback))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            Spacer()
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .bottom) {
                    TextField("Run after work!", text: $viewModel.task.title)
                        .frame(height: 23)
                        .font(.custom("Manjari-Bold", size: 20))
                    
                    Spacer()
                    
                    Text("\(viewModel.task.title.count)/\(viewModel.titleLimit)")
                        .frame(height: 14)
                        .font(.custom("Manjari-Bold", size: 12))
                        .padding(.bottom, 1)
                        .onChange(of: viewModel.task.title, viewModel.limitTitle)
                }
                .padding(.leading, 22)
                .padding(.trailing, 21)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .frame(width: 159, height: 1)
                    .padding(.top, 4)
                
                TextEditor(text: $viewModel.task.desc)
                    .placeHolder("Make sure that it is long and slow; do not make it fast, as that will only hinder my progress. It should be slow but steady.", text: $viewModel.task.desc)
                    .frame(height: 100.0)
                    .padding(.leading, 23)
                    .padding(.trailing, 18)
                    .padding(.top, 11)
                    .font(.custom("Manjari-Bold", size: 16))
                
                HStack {
                    Spacer()
                    
                    Text("\(viewModel.task.desc.count)/\(viewModel.descriptionLimit)")
                        .frame(height: 14)
                        .font(.custom("Manjari-Bold", size: 12))
                        .padding(.bottom, 4)
                        .onChange(of: viewModel.task.desc, viewModel.limitDescription)
                }
                .padding(.trailing, 21)
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Divider()
                            .frame(width: 73.21, height: 1)
                    }
                }
                
                Tags(text: $viewModel.task.tags, tagsLimit: viewModel.tagsLimit)

                HStack {
                    Spacer()
                    
                    Text("\(viewModel.task.tags.count)/\(viewModel.tagsLimit)")
                        .frame(height: 14)
                        .font(.custom("Manjari-Bold", size: 12))
                        .onChange(of: viewModel.task.tags, viewModel.limitTags)
                }
                .padding(.trailing, 20)
                .padding(.top, 11)
                
                HStack {
                    HStack(alignment: .top, spacing: 0) {
                        Image(.ok)
                            .padding(.trailing, 4)
                        
                        Text(viewModel.task.timeElapsedFormatted)
                            .frame(height: 19)
                            .font(.custom("Manjari-Bold", size: 16))
                            .padding(.top, 1)
                    }
                    .frame(height: 20, alignment: .top)
                    
                    Spacer()
                    
                    Button {
                        viewModel.isAlertPresented = true
                    } label: {
                        Image(.trash)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
                .frame(height: 20)
                .padding(.trailing, 16)
                .padding(.leading, 19)
                .padding(.top, 26)
            }
            .padding(.top, 57.0)
            .padding(.bottom, 31.0)
            .frame(maxWidth: .infinity)
            .background(Color("Background"))
            .clipShape(.rect(topLeadingRadius: 37, topTrailingRadius: 37))
            .shadow(color: .black.opacity(0.25), radius: 23.6, x: -4, y: 1)
            .offset(y: viewModel.isBottomSheetShow ? 0 : 500)
            .onAppear {
                viewModel.isBottomSheetShow = false
                withAnimation(.easeInOut(duration: 0.5)){
                    viewModel.isBottomSheetShow = true
                }
            }
        }
        .ignoresSafeArea(.container, edges: .bottom)
        .customAlert(isPresented: $viewModel.isAlertPresented) {
            CustomAlert {
                Text("Are you sure")
                    .font(.custom("Manjari-Bold", size: 30))
            } message: {
                Text("You want to delete ")
                    .font(.custom("Manjari-Regular", size: 18))
                + Text(viewModel.task.title)
                    .font(.custom("Manjari-Bold", size: 18))
                + Text("?")
                    .font(.custom("Manjari-Regular", size: 18))
            } actions : {
                HStack(alignment: .center, spacing: .zero){
                    Button {
                        viewModel.deleteTask()
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
    Detail(task: .example, isDetailPresented: .constant(true), callback: { _ in })
}
