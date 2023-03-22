//
//  CalendarView.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Utils

import ComposableArchitecture

public struct CalendarView: View {
    let store: StoreOf<Calendar>
    
    private let weeks: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    public init() {
        self.store = .init(initialState: .init(), reducer: Calendar()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 7)) {
                    ForEach(weeks, id: \.self) { week in
                        VStack {
                            Text(week)
                                .font(.caption2)
                                .fontWeight(.light)
                        }
                    }
                    
                    ForEach(viewStore.calendarFiles) { calendarFile in
                        VStack {
                            HStack(spacing: .zero) {
                                Spacer()
                                Text("\(calendarFile.date.day)")
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                            
                            HStack(spacing: .zero) {
                                Divider()
                                    .frame(width: 2, height: 10)
                                    .overlay(.green)
                                    .cornerRadius(2, corners: .allCorners)
                                    .padding(.trailing, 3)
                                
                                Text("dd")
                                    .font(.caption2)
                                    .fontWeight(.light)
                                
                                Spacer()
                            }
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
                            viewStore.send(.setSheet(isPresented: true))
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.title3)
                        }
                    }
                    
                    ForEach(1..<3) { _ in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("12:00 PM")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                
                                Text("1:00 PM")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
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
                EditCalendarView()
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
