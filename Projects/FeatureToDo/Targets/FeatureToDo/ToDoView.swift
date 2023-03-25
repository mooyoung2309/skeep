//
//  ToDoView.swift
//  FeatureToDo
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
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
                .overlay(file.colorPalette.color)
                .cornerRadius(2, corners: .allCorners)
            
            Text(file.title)
            
            Spacer()
        }
    }
}


public struct ToDoView: View {
    let store: StoreOf<ToDo>
    
    private let weeks: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State private var calendarId: UUID = UUID()
    
    public init() {
        self.store = .init(initialState: .init(), reducer: ToDo()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    DatePicker(
                        "",
                        selection: viewStore.binding(get: \.date, send: ToDo.Action.setDate),
                        displayedComponents: [.date]
                    )
                    .id(calendarId)
                    .onChange(of: viewStore.date, perform: { _ in
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
                    ForEach(viewStore.toDoFiles) { toDoFile in
                        VStack(spacing: 10) {
                            Text(toDoFile.date.toString(format: "E"))
                                .font(.caption2)
                                .fontWeight(.light)
                            
                            Text(toDoFile.date.toString(format: "d"))
                                .font(.body)
                        }
                        .onTapGesture {
                            viewStore.send(.setDate(toDoFile.date), animation: .default)
                        }
                    }
                }
                .padding([.horizontal, .bottom])
                
                if let files = viewStore.toDoFile?.files {
                    ForEach(files) { file in
                        FileItemView(file: file)
                            .padding()
                            .onTapGesture {
//                                viewStore.send(.tapFileLabel(file))
                            }
                            .background(Color(.systemGray6))
                            .cornerRadius(10, corners: .allCorners)
                    }
                    .padding(.horizontal)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .navigationTitle("To-Do")
            .task {
                viewStore.send(.refresh)
            }
        }
    }
}

public struct ToDoView_Previews: PreviewProvider {
    public static var previews: some View {
        ToDoView()
    }
}
