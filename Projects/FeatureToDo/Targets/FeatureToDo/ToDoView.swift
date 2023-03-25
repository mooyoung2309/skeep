//
//  ToDoView.swift
//  FeatureToDo
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

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
                DatePicker(
                    "",
                    selection: viewStore.binding(get: \.date, send: ToDo.Action.selectDate),
                    displayedComponents: [.date]
                )
                .id(calendarId)
                .onChange(of: viewStore.date, perform: { _ in
                    calendarId = UUID()
                })
                .padding(.horizontal)
                
                LazyVGrid(columns: .init(repeating: .init(), count: 7)) {
                    ForEach(viewStore.toDoFiles) { toDoFile in
                        VStack(spacing: 10) {
                            Text(toDoFile.date.toString(format: "E"))
                                .font(.caption2)
                                .fontWeight(.light)
                            
                            Text(toDoFile.date.toString(format: "d"))
                                .font(.body)
                        }
                    }
                }
                .padding([.horizontal, .bottom])
                
                ForEach(0..<10) { i in
                    HStack {
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "face.dashed")
                                .font(.title3)
                        })
                        
                        Divider()
                            .frame(width: 5)
                            .overlay(.green)
                            .cornerRadius(2, corners: .allCorners)
                        
                        Text("나의 할일")
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10, corners: .allCorners)
                }
                .padding(.horizontal)
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
