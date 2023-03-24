//
//  CalendarEditView.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core
import Utils

import ComposableArchitecture

public struct EditCalendarView: View {
    @State private var someBinding = true
    @State var animate = false
    let store: StoreOf<EditCalendar>
    
    public init(file: File) {
        self.store = .init(initialState: .init(file: file), reducer: EditCalendar()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                HStack {
                    Divider()
                        .frame(width: 4)
                        .overlay(viewStore.file.colorPalette.color)
                    
                    TextField(
                        "Title",
                        text: viewStore.binding(get: \.file.title, send: EditCalendar.Action.titleChanged)
                    )
                    .font(.title3)
                    .bold()
                }
                .padding([.top, .horizontal])
                
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
                    
                    DatePicker("", selection: viewStore.binding(get: \.date, send: EditCalendar.Action.selectDate))
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
                    Label("", systemImage: "face.dashed")
                    
                    Toggle("To-Do", isOn: $someBinding)
                        .toggleStyle(.switch)
                }
                .padding()
                
                /*TODO: 메모 기능 추가
                HStack {
                    Label("", systemImage: "doc.plaintext")
                    
                    Text("Memo")
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                TextEditor(
                    text: viewStore.binding(get: \.file.content, send: EditCalendar.Action.contentChanged)
                )
                .foregroundColor(.gray)
                .frame(minHeight: 50)
                .padding([.bottom, .horizontal])
                 
                 */
            }
        }
    }
}
