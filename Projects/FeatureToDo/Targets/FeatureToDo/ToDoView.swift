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
                
                TabView {
                    LazyVGrid(columns: .init(repeating: .init(), count: 7)) {
                        ForEach(0..<7, id: \.self) { value in
                            VStack(spacing: 15) {
                                Text(weeks[value])
                                    .font(.caption2)
                                    .fontWeight(.light)
                            }
                        }
                    }
                    
                    LazyVGrid(columns: .init(repeating: .init(), count: 7)) {
                        ForEach(0..<7, id: \.self) { value in
                            HStack {
                                Spacer()
                                Text(String(format: "%x", value))
                                Spacer()
                            }
                        }
                    }
                    
                    LazyVGrid(columns: .init(repeating: .init(), count: 7)) {
                        ForEach(0..<7, id: \.self) { value in
                            HStack {
                                Spacer()
                                Text(String(format: "%x", value))
                                Spacer()
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .frame(minWidth: 100, minHeight: 80)
                
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
        }
    }
}

public struct ToDoView_Previews: PreviewProvider {
    public static var previews: some View {
        ToDoView()
    }
}
