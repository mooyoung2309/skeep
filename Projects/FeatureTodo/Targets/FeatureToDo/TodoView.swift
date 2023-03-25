//
//  ToDoView.swift
//  FeatureToDo
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import FeatureCommon
import Core

import ComposableArchitecture

struct FileItemView: View {
    let file: File
    
    init(file: File) {
        self.file = file
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(file.startDate.toString(format: "HH:mm a"))")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text("\(file.endDate.toString(format: "HH:mm a"))")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Divider()
                .frame(width: 5)
                .overlay(Color(rgb: file.rgb))
                .cornerRadius(2, corners: .allCorners)
            
            Text(file.title)
            
            Spacer()
        }
    }
}


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
                        Image(systemName: "square.and.pencil")
                            .font(.title3)
                    }
                }
                .padding(.horizontal)
                
                if let files = viewStore.todoFiles.first(where: { $0.date.isDate(inSameDayAs: viewStore.selectedDate) })?.files {
                    ForEach(files) { file in
                        FileItemView(file: file)
                            .padding()
                            .onTapGesture {
                                viewStore.send(.tapFileItemView(file))
                            }
                            .background(Color(.systemGray6))
                            .cornerRadius(10, corners: .allCorners)
                    }
                    .padding(.horizontal)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .navigationTitle("To-Do")
            .sheet(isPresented: viewStore.binding(get: \.isSheetPresented, send: Todo.Action.setSheet(isPresented:))) {
                EditFileView(store: self.store.scope(state: \.editFile, action: Todo.Action.editFile))
                    .presentationDetents([.medium])
            }
            .task {
                viewStore.send(.refresh)
            }
        }
    }
}
