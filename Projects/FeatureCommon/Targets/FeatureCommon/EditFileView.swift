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
    @State var toggle1On = false
    
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
                
                //MARK: Color
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
                
                //MARK: Calendar Date
                HStack {
                    Label("", systemImage: "clock")
                    
                    VStack(alignment: .leading) {
                        if !viewStore.file.isAllday {
                            Text("\(viewStore.file.startDate.toString(format: "MM-dd (E)"))")
                                .font(.subheadline)
                                .fontWeight(.light)
                            
                            Text("\(viewStore.file.startDate.toString(format: "HH:mm a"))")
                                .font(.title2)
                                .fontWeight(.bold)
                        } else {
                            Text("\(viewStore.file.startDate.toString(format: "MM-dd (E)"))")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                    }
                    .onTapGesture {
                        viewStore.send(.tapStartDateView, animation: .default)
                    }
                    
                    Image(systemName: "chevron.right")
                        .disabled(viewStore.file.isAllday)
                        .opacity(viewStore.file.isAllday ? 0 : 1)
                    
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
                    .disabled(viewStore.file.isAllday)
                    .opacity(viewStore.file.isAllday ? 0 : 1)
                    
                    Spacer()
                    
                    Button {
                        viewStore.send(.isAlldayToggleChanged, animation: .default)
                    } label: {
                        Text("All day")
                            .font(.caption)
                            .foregroundColor(viewStore.file.isAllday ? .black : .gray)
                            .padding(10)
                            .background(viewStore.file.isAllday ? Color(.systemGray4) : Color(.systemGray6))
                            .cornerRadius(10, corners: .allCorners)
                    }
                }
                .padding([.top, .horizontal])
                
                //MARK: DatePicker
                HStack {
                    Spacer()
                    
                    DatePicker(
                        "",
                        selection: viewStore.binding(get: \.file.startDate, send: EditFile.Action.startDateChanged)
                    )
                    .datePickerStyle(.wheel)
                    .onAppear {
                        UIDatePicker.appearance().minuteInterval = 10
                    }
                    
                    Spacer()
                }
                .frame(height: viewStore.mode != .start ? 0 : 200)
                .opacity(viewStore.mode != .start ? 0 : 1)
                
                HStack {
                    Spacer()
                    
                    DatePicker(
                        "",
                        selection: viewStore.binding(get: \.file.endDate, send: EditFile.Action.endDateChanged)
                    )
                    .datePickerStyle(.wheel)
                    .onAppear {
                        UIDatePicker.appearance().minuteInterval = 10
                    }
                    
                    Spacer()
                }
                .frame(height: viewStore.mode != .end ? 0 : 200)
                .opacity(viewStore.mode != .end ? 0 : 1)
                
                //MARK: Archive
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

                            Spacer()
                        }
                    }
                }
                .padding()
                
                //MARK: 반복 기능
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
                        
                        let repeatStype = viewStore.file.repeatStyle
                        
                        if repeatStype == .daily {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .center) {
                                    ForEach(Array(Calendar.current.shortStandaloneWeekdaySymbols.enumerated()), id: \.offset) { index, week in
                                        Button {
                                            viewStore.send(.weekdayChanged(Int(index) + 1))
                                        } label: {
                                            let weekdays = WeekdayManager.toWeekdays(uint8: UInt8(viewStore.state.file.weekdays))
                                            
                                            Text(week)
                                                .font(.caption2)
                                                .foregroundColor(weekdays.contains(index + 1) ? .black : .gray)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 5)
                                                .background(weekdays.contains(index + 1) ? Color(.systemGray4) : Color(.systemGray6))
                                                .cornerRadius(7, corners: .allCorners)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        
                        HStack {
                            Spacer()

                            DatePicker(
                                "",
                                selection: viewStore.binding(get: \.file.repeatFinishDate, send: EditFile.Action.repeatFinishDateChanged),
                                displayedComponents: [.date]
                            )
                            .foregroundColor(viewStore.file.isUseFinishDate ? .black : .gray)

                            Button(action: {
                                viewStore.send(.isUseFinishDateChanged)
                            }, label: {
                                Label("Finish", systemImage: "clock.arrow.circlepath")
                                    .font(.caption)
                                    .foregroundColor(viewStore.file.isUseFinishDate ? .black : .gray)
                                    .padding(10)
                                    .background(viewStore.file.isUseFinishDate ? Color(.systemGray4) : Color(.systemGray6))
                                    .cornerRadius(10, corners: .allCorners)
                            })
                        }
                        .opacity(viewStore.file.repeatStyle == .none ? 0 : 1)
                        .disabled(viewStore.file.repeatStyle == .none)
                    }
                }
                .padding()
            }
        }
    }
}
