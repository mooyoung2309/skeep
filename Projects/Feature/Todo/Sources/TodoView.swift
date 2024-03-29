//
//  ToDoView.swift
//  FeatureToDo
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import FeatureCommon
import FeatureAccount
import Core

import ComposableArchitecture

public struct TodoView: View {
    let store: StoreOf<Todo>
    
    private let weeks: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State private var calendarId: UUID = UUID()
    
    public init() {
        self.store = .init(initialState: .init(), reducer: Todo()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    DatePicker(
                        "",
                        selection: viewStore.binding(get: \.selectedDate, send: Todo.Action.selectDate),
                        displayedComponents: [.date]
                    )
                    .id(calendarId)
                    .onChange(of: viewStore.selectedDate, perform: { _ in
                        calendarId = UUID()
                    })
                    .padding(.horizontal)
                    
                    Button(action: {
                        viewStore.send(.tapLeftButton, animation: .default)
                    }, label: {
                        Image(systemName: "chevron.left")
                            .fontWeight(.bold)
                    })
                    
                    Button(action: {
                        viewStore.send(.tapRightButton, animation: .default)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .fontWeight(.bold)
                    })
                }
                .padding([.horizontal, .bottom])
                
                LazyVGrid(columns: .init(repeating: .init(), count: 7)) {
                    ForEach(viewStore.todoFiles) { todoFile in
                        VStack(spacing: .zero) {
                            Text(todoFile.date.toString(format: "E"))
                                .font(.caption2)
                                .fontWeight(.light)
                                .padding(.bottom, 10)
                            
                            Text(todoFile.date.toString(format: "d"))
                                .font(.body)
                                .padding(.bottom, 5)
                            
                            Text(todoFile.files.count == 0 ? "" : "\(todoFile.files.count)")
                                .font(.caption2)
                                .fontWeight(.semibold)
                        }
                        .onTapGesture {
                            viewStore.send(.selectDate(todoFile.date), animation: .default)
                        }
                    }
                }
                .padding([.horizontal])
                
                HStack {
                    Text(Date.toString(date: viewStore.selectedDate))
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        viewStore.send(.tapTodoButton)
                    } label: {
                        Image(systemName: "plus.app.fill")
                            .font(.title3)
                    }
                }
                .padding()
                
                ForEach(viewStore.selectedFiles) { file in
                    HStack {
                        Button(action: {
                            viewStore.send(.doneToggleChanged(file))
                        }, label: {
                            Image(systemName: file.isDone(date: viewStore.selectedDate) ? "checkmark.square" : "square")
                        })
                        .foregroundColor(file.isDone(date: viewStore.selectedDate) ? .gray : .black)
                        
                        Divider()
                            .frame(width: 5)
                            .overlay(Color(rgb: file.rgb))
                            .cornerRadius(2, corners: .allCorners)
                        
                        Text(file.title)
                            .foregroundColor(file.isDone(date: viewStore.selectedDate) ? .gray : .black)
                            .strikethrough(file.isDone(date: viewStore.selectedDate))
                            .lineLimit(1)
                        
                        Spacer()
                    }
                    .padding()
                    .onTapGesture {
                        viewStore.send(.tapFileItemView(file))
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(10, corners: .allCorners)
                    .padding(.horizontal)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewStore.send(.setAccountSheet(isPresented: true))
                    }, label: {
                        Image(systemName: "person.crop.circle")
                            .fontWeight(.bold)
                    })
                }
            }
            .sheet(isPresented: viewStore.binding(get: \.isSheetPresented, send: Todo.Action.setSheet(isPresented:))) {
                EditFileView(store: self.store.scope(state: \.editFile, action: Todo.Action.editFile))
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: viewStore.binding(get: \.isAccountSheetPresented, send: Todo.Action.setAccountSheet(isPresented:))) {
                AccountView()
            }
            .task {
                viewStore.send(.refresh, animation: .default)
            }
        }
    }
}
