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
            ScrollView(showsIndicators: false) {
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
                    
                    Button {
                        viewStore.send(.calendarStyleChanged(.allday))
                    } label: {
                        Text("All day")
                            .font(.caption)
                            .foregroundColor(viewStore.file.calendarStyle == .allday ? .black : .gray)
                            .padding(10)
                            .background(viewStore.file.calendarStyle == .allday ? Color(.systemGray4) : Color(.systemGray6))
                            .cornerRadius(10, corners: .allCorners)
                    }
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
                
                HStack {
                    Label("", systemImage: "arrow.2.squarepath")
                    
                    VStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .center) {
                                ForEach(RepeatStyle.allCases, id: \.rawValue) { repeatStyle in
                                    Button {
                                        viewStore.send(.repeatStyleChanged(repeatStyle), animation: .default)
                                    } label: {
                                        Text(repeatStyle.title)
                                            .font(.caption)
                                            .foregroundColor(viewStore.file.repeatStyle == repeatStyle ? .black : .gray)
                                            .padding(10)
                                            .background(viewStore.file.repeatStyle == repeatStyle ? Color(.systemGray4) : Color(.systemGray6))
                                            .cornerRadius(10, corners: .allCorners)
                                    }
                                }
                                Spacer()
                            }
                        }
                        if viewStore.file.repeatStyle == .daily {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .center) {
                                    ForEach(Calendar.current.shortStandaloneWeekdaySymbols, id: \.hashValue) { week in
                                        Button {
    //                                        viewStore.send(.repeatStyleChanged(repeatStyle))
                                        } label: {
                                            Text(week)
                                                .font(.caption2)
                                                .foregroundColor(true ? .black : .gray)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 5)
                                                .background(true ? Color(.systemGray4) : Color(.systemGray6))
                                                .cornerRadius(7, corners: .allCorners)
                                        }
                                    }
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .padding()
                
                HStack {
                    Label("", systemImage: "archivebox")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Button(action: {
                                viewStore.send(.calendarToggleChanged)
                            }, label: {
                                Label("Calendar", systemImage: "calendar")
                                    .font(.caption)
                                    .foregroundColor(viewStore.file.calendarStyle == .none ? .gray : .black)
                                    .padding(10)
                                    .background(viewStore.file.calendarStyle == .none ? Color(.systemGray6) : Color(.systemGray4))
                                    .cornerRadius(10, corners: .allCorners)
                            })
                            
                            Button(action: {
                                viewStore.send(.todoToggleChanged)
                            }, label: {
                                Label("Todo", systemImage: "checkmark.square.fill")
                                    .font(.caption)
                                    .foregroundColor(viewStore.file.todoStyle == .none ? .gray : .black)
                                    .padding(10)
                                    .background(viewStore.file.todoStyle == .none ? Color(.systemGray6) : Color(.systemGray4))
                                    .cornerRadius(10, corners: .allCorners)
                            })
                            
                            Button(action: {
                                viewStore.send(.habitToggleChanged)
                            }, label: {
                                Label("Habit", systemImage: "face.dashed")
                                    .font(.caption)
                                    .foregroundColor(viewStore.file.habitStyle == .none ? .gray : .black)
                                    .padding(10)
                                    .background(viewStore.file.habitStyle == .none ? Color(.systemGray6) : Color(.systemGray4))
                                    .cornerRadius(10, corners: .allCorners)
                            })
                            
                            Spacer()
                        }
                    }
                }
                .padding()
            }
        }
    }
}
