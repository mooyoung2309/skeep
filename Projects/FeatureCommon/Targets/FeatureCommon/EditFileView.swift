//
//  EditFileView.swift
//  FeatureCommon
//
//  Created by 송영모 on 2023/03/25.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core
import Utils

import ComposableArchitecture

public struct EditFileView: View {
    let store: StoreOf<EditFile>
    @State private var animate = false
    
    public init(store: StoreOf<EditFile>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                if viewStore.tab == .calendar || viewStore.tab == .todo {
                    HStack {
                        Divider()
                            .frame(width: 4)
                            .overlay(Color(rgb: viewStore.file.rgb))
                        
                        TextField(
                            "Title",
                            text: viewStore.binding(get: \.file.title, send: EditFile.Action.titleChanged)
                        )
                        .font(.title3)
                        .bold()
                    }
                    .padding([.top, .horizontal])
                }
                
                HStack {
                    Label("", systemImage: "paintpalette")
                    
                    ScrollView(.horizontal) {
                        HStack(alignment: .center) {
                            ForEach(ColorPalette.allCases, id: \.rawValue) { colorPalette in
                                Button {
                                    viewStore.send(.colorChanged(colorPalette.color))
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
                        viewStore.send(.tapStartDateView, animation: .default)
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
                        viewStore.send(.tapEndDateView, animation: .default)
                    }
                    
                    Spacer()
                    
                    Toggle("All Day", isOn: viewStore.binding(get: \.file.calendarStyle.isAllDay, send: EditFile.Action.allDayToggleChanged))
                        .toggleStyle(.button)
                }
                .padding()
                
                HStack {
                    Spacer()
                    
                    DatePicker("", selection: viewStore.binding(get: \.date, send: EditFile.Action.dateChanged))
                        .datePickerStyle(.wheel)
                    
                    Spacer()
                }
                .frame(height: viewStore.mode == .none ? 0 : 200)
                .opacity(viewStore.mode == .none ? 0 : 1)
                
                /*TODO: 노티피케이션 기능 추가
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
                 
                 */
                
                HStack {
                    Label("", systemImage: "face.dashed")
                    
                    Toggle("To-Do", isOn: viewStore.binding(get: \.file.todoStyle.isShow, send: EditFile.Action.toDoToggleChanged))
                        .toggleStyle(.switch)
                }
                .padding()
            }
        }
    }
}
