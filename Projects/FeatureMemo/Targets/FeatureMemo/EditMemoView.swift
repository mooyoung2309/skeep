//
//  MemoEditView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core

import ComposableArchitecture

struct EditMemoView: View {
    @State private var someBinding = true
    @State var animate = false
    let store: StoreOf<EditMemo>
    
    init(file: File) {
        self.store = .init(initialState: .init(file: file), reducer: EditMemo()._printChanges())
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    Divider()
                        .frame(width: 5)
                        .overlay(viewStore.file.colorPalette.color)
                    
                    TextField(
                        "Title",
                        text: viewStore.binding(get: \.file.title, send: EditMemo.Action.titleChanged)
                    )
                    .font(.title)
                    .bold()
                }
                
                TextEditor(
                    text: viewStore.binding(get: \.file.content, send: EditMemo.Action.contentChanged)
                )
                .frame(minHeight: 100)
                
                Spacer()
            }
            .sheet(isPresented: viewStore.binding(get: \.isSheetPresented, send: EditMemo.Action.setSheet(isPresented:))) {
                ScrollView {
                    HStack {
                        Label("", systemImage: "paintpalette")
                        
                        ScrollView(.horizontal) {
                            HStack(alignment: .center) {
                                ForEach(ColorPalette.allCases, id: \.rawValue) { colorPalette in
                                    Button {
                                        viewStore.send(.selectColorPalette(colorPalette))
                                    } label: {
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .foregroundColor(colorPalette.color)
                                            .frame(width: 25, height: 25)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    
                    HStack {
                        Label("", systemImage: "clock")
                        
                        VStack(alignment: .leading) {
                            Text("\(viewStore.file.startDate.toString(format: "MM-dd (E)"))")
                                .font(.subheadline)
                                .fontWeight(.light)
                            
                            Text("\(viewStore.file.startDate.toString(format: "HH:mm a"))")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .onTapGesture {
                            viewStore.send(.selectStartDate, animation: .default)
                        }
                        
                        Image(systemName: "chevron.right")
                        
                        VStack(alignment: .leading) {
                            Text("\(viewStore.file.endDate.toString(format: "MM-dd (E)"))")
                                .font(.subheadline)
                                .fontWeight(.light)
                            
                            Text("\(viewStore.file.endDate.toString(format: "HH:mm a"))")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        .onTapGesture {
                            withAnimation {
                                self.animate.toggle()
                            }
                            viewStore.send(.selectEndDate, animation: .default)
                        }
                        
                        Spacer()
                        
                        Toggle("All Day", isOn: $someBinding)
                            .toggleStyle(.button)
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        
                        DatePicker("", selection: viewStore.binding(get: \.date, send: EditMemo.Action.selectDate))
                            .datePickerStyle(.wheel)
                        
                        Spacer()
                    }
                    .frame(height: viewStore.editDateMode == .none ? 0 : 200)
                    .opacity(viewStore.editDateMode == .none ? 0 : 1)

                    HStack {
                        Label("", systemImage: "bell")
                        
                        Text("Notification")
                        
                        Spacer()
                        
                        Menu {
                            Button("None", action: {})
                            
                            Button("10m", action: {})
                            
                            Button("30m", action: {})
                            
                            Button("1h", action: {})
                            
                            Button("12h", action: {})
                            
                            Button("24h", action: {})
                        } label: {
                            Label("None", systemImage: "hourglass.badge.plus")
                        }
                    }
                    .padding()
                    
                    HStack {
                        Label("", systemImage: "calendar")
                        
                        Toggle("Calendar", isOn: viewStore.binding(get: \.file.calendarStyle.isShow, send: EditMemo.Action.calendarToggleChanged))
                            .toggleStyle(.switch)
                    }
                    .padding()
                    
                    HStack {
                        Label("", systemImage: "face.dashed")
                        
                        Toggle("To-Do", isOn: viewStore.binding(get: \.file.toDoStyle.isShow, send: EditMemo.Action.toDoToggleChanged))
                            .toggleStyle(.switch)
                    }
                    .padding()
                }
                .presentationDetents([.medium])
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewStore.send(.setSheet(isPresented: true))
                    }, label: {
                        Label("", systemImage: "sun.min")
                    })
                }
            }
        }
    }
}