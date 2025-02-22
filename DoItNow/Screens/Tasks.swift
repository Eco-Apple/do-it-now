//
//  List.swift
//  DoItNow
//
//  Created by Jerico Villaraza on 12/30/24.
//

import SwiftUI

struct ButtonPositionPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

struct Tasks: View {
    @Environment(\.navigate) var navigate
    
    @State var viewModel = ViewModel(dataService: .shared)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if !viewModel.tasks.isEmpty {
                    HStack {
                        Text("Recents")
                            .foregroundStyle(.recents)
                            .font(.custom("Manjari-Regular", size: 14))
                            .opacity(viewModel.isRecentShow ? 1 : 0)
                            .offset(x: viewModel.isRecentShow ? 0 : -5)
                            .animation(.easeInOut(duration: 0.5), value: viewModel.isRecentShow)
                        
                        Spacer()
                        
                        Button {
                            viewModel.sort()
                        } label: {
                            Image(.sort)
                                .background(
                                    GeometryReader { proxy in
                                        Color.clear
                                            .preference(key: ButtonPositionPreferenceKey.self, value: proxy.frame(in: .global).origin)
                                    }
                                )
                        }
                        .opacity(viewModel.isSortButtonShow ? 1 : 0)
                        .offset(x: viewModel.isSortButtonShow ? 0: 5)
                        .animation(.easeInOut(duration: 0.5), value: viewModel.isSortButtonShow)
                        
                    }
                    .onPreferenceChange(ButtonPositionPreferenceKey.self) { value in
                        viewModel.sortButtonPosition = value
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 7)
                    .padding(.leading, 19)
                    .padding(.trailing, 21)
                    
                    if viewModel.isTasksShow {
                        VStack(spacing: 0) {
                            ForEach(Array(viewModel.tasks.enumerated()), id: \.element.id) { index, task in
                                Button {
                                    viewModel.isDetailPresented = true
                                    viewModel.taskSelected = task
                                } label : {
                                    TasksItem(task: task, index: index)
                                        .padding(.bottom, 12)
                                        .contentShape(Rectangle())
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 19)
                        .padding(.trailing, 21)
                        .onChange(of: viewModel.isDetailPresented) {
                            if viewModel.isDetailPresented {
                                withAnimation(.easeInOut(duration: 0.5)){
                                    viewModel.isAddBSOverlayShow = true
                                }
                            } else if !viewModel.isAddPresented {
                                viewModel.isAddBSOverlayShow = false
                            }
                        }
                    }
                    
                    if viewModel.isNextPage {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.black)
                            .foregroundColor(.red)
                            .onAppear {
                                viewModel.loadNextPage()
                            }
                    }
                } else {
                    NoTasks()
                        .opacity(viewModel.isNoTaskShow ? 1: 0)
                        .animation(.easeInOut(duration: 0.5), value: viewModel.isNoTaskShow)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color("Background"))
        .customToolbar {
            HStack(spacing: .zero) {
                Image("logo")
                    .resizable()
                    .frame(width: 36.27, height: 39)
                
                Spacer()
                
                Button {
                    viewModel.isAddPresented = true
                } label: {
                    VStack {
                        Image("plus")
                    }
                    .frame(width: 31, height: 31)
                    .background {
                        Color.white
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.stroke, lineWidth: 1)
                            }
                    }
                }
                .opacity(viewModel.isAddButtonShow ? 1 : 0)
                .animation(.easeInOut(duration: 1), value: viewModel.isAddButtonShow)
                .onChange(of: viewModel.isAddPresented) {
                    if viewModel.isAddPresented {
                        withAnimation(.easeInOut(duration: 0.5)){
                            viewModel.isAddBSOverlayShow = true
                        }
                    } else if !viewModel.isAddPresented {
                        viewModel.isAddBSOverlayShow = false
                    }
                }
            }
            .padding(.leading, 23.73)
            .padding(.trailing, 24)
            .padding(.bottom, 15)
            .background(Color("Background"))
        }
        .customAlert(isPresented: $viewModel.isDetailPresented) {
            if let taskSelected = viewModel.taskSelected {
                Detail(task: taskSelected, isDetailPresented: $viewModel.isDetailPresented) { response in
                    switch response {
                    case .success(let message, let mode):
                        if mode == .delete {
                            viewModel.tasks.removeAll { task in
                                task.id == taskSelected.id
                            }
                        } else if mode == .start {
                            navigate(.add(.timer(taskSelected)))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                viewModel.isDetailPresented = false
                                viewModel.taskSelected = nil
                            }
                        }
                    case .failure(let message):
                        debugPrint(message)
                    }
                    
                }
            }
        }
        .customAlert(isPresented: $viewModel.isAddPresented, isOverlayShow: $viewModel.isAddBSOverlayShow) {
            Add { task, mode in
                viewModel.addCallback(task: task, mode: mode, navigate: navigate)
            }
        }
        .customAlert(isPresented: $viewModel.isSortPresented) {
            Sort(cgPoint: viewModel.sortButtonPosition, callback: viewModel.sortCallback)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                viewModel.isAddButtonShow = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.isRecentShow = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                viewModel.isNoTaskShow = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.isSortButtonShow = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.isTasksShow = true
            }
        }
    }
}

#Preview {
    Tasks()
}
