//
//  CalendarView.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core
import Utils

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

struct FileLabelView: View {
    let file: File
    
    init(file: File) {
        self.file = file
    }
    
    var body: some View {
        HStack(spacing: .zero) {
            Divider()
                .frame(width: 2, height: 10)
                .overlay(Color(rgb: file.rgb))
                .cornerRadius(2, corners: .allCorners)
                .padding(.trailing, 3)
            
            Text(file.title)
                .font(.caption2)
                .fontWeight(.light)
            
            Spacer()
        }
    }
}

public struct CalendarView: View {
    let store: StoreOf<Calendar>
    
    private let weeks: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    public init() {
        self.store = .init(initialState: .init(), reducer: Calendar()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7), spacing: .zero) {
                    ForEach(weeks, id: \.self) { week in
                        VStack {
                            Text(week)
                                .font(.caption2)
                                .fontWeight(.light)
                        }
                    }
                    
                    ForEach(viewStore.calendarFiles) { calendarFile in
                        VStack(spacing: .zero) {
                            HStack(spacing: .zero) {
                                Spacer()
                                Text("\(calendarFile.date.day)")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .opacity(
                                        calendarFile.date.month == viewStore.date.month
                                        ? 1 : 0.4
                                    )
                                Spacer()
                            }
                            
                            ForEach(calendarFile.files) { file in
                                FileLabelView(file: file)
                            }
                            
                            Spacer()
                        }
                        .onTapGesture {
                            viewStore.send(.selectCalendarCell(calendarFile.date), animation: .default)
                        }
                        .frame(height: UIScreen.screenHeight * 0.08)
                    }
                }
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Text(Date.toString(date: viewStore.date))
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button {
                            viewStore.send(.tapMemoButton)
                        } label: {
                            Image(systemName: "calendar.badge.plus")
                                .font(.title3)
                        }
                    }
                    
                    if let calendarFile = viewStore.calendarFile {
                        ForEach(calendarFile.files) { file in
                            FileItemView(file: file)
                                .padding()
                                .onTapGesture {
                                    viewStore.send(.tapFileLabel(file))
                                }
                                .background(Color(.systemGray6))
                                .cornerRadius(10, corners: .allCorners)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text(Date.toString(format: "yyyy.MM", date: viewStore.date))
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewStore.send(.tapLeftButton, animation: .default)
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.caption)
                            .fontWeight(.bold)
                    })
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewStore.send(.tapRightButton, animation: .default)
                    }, label: {
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .fontWeight(.bold)
                    })
                }
            }
            .sheet(isPresented: viewStore.binding(get: \.isSheetPresented, send: Calendar.Action.setSheet(isPresented:))) {
                EditCalendarView(file: viewStore.file)
                    .presentationDetents([.medium])
            }
            .task {
                viewStore.send(.refresh)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
