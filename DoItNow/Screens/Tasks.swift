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
    @Environment(OverlayObservable.self) var overlayObservable
    
    @State var viewModel = ViewModel(dataService: .shared)
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                HStack {
                    Text("Recents")
                        .foregroundStyle(.recents)
                        .font(.custom("Manjari-Regular", size: 14))
                    
                    Spacer()
                    
                    Button {
                        viewModel.filter(overlayObservable: overlayObservable)
                    } label: {
                        Image(.filter)
                            .background(
                                GeometryReader { proxy in
                                    Color.clear
                                        .preference(key: ButtonPositionPreferenceKey.self, value: proxy.frame(in: .global).origin)
                                }
                            )
                    }
                    
                }
                .onPreferenceChange(ButtonPositionPreferenceKey.self) { value in
                    viewModel.filterButtonPosition = value
                }
                .padding(.top, 96)
                .padding(.bottom, 7)
                .padding(.leading, 19)
                .padding(.trailing, 21)
                
                VStack {
                    ForEach(viewModel.tasks) { task in
                        Button {
                        } label : {
                            TasksItem(task: task)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 19)
                .padding(.trailing, 21)
                
                if viewModel.isNextPage {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.black)
                        .foregroundColor(.red)
                        .onAppear {
                            viewModel.loadNextPage()
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image("toolbar-logo")
                    .padding(.leading, 5.73)
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.add(overlayObservable: overlayObservable)
                } label : {
                    Image("plus")
                        .padding(4.9)
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
            }
        }
    }
}

#Preview {
    let overlayObsrvable = OverlayObservable()
    
    Tasks()
        .environment(overlayObsrvable)
}
