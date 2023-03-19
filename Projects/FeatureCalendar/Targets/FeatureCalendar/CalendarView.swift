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
    
    public init() {
        self.store = .init(initialState: .init(), reducer: Calendar()._printChanges())
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                ScrollView(.horizontal) {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: .zero), count: 7)) {
                        ForEach(viewStore.calendarFiles) { calendarFile in
                            VStack {
                                HStack {
                                    Spacer()
                                    
                                    Text("\(calendarFile.date.day)")
                                    
                                    Spacer()
                                }
                                Spacer()
                            }
                            .background(Color.purple)
                        }
                        .frame(height: UIScreen.screenHeight * 0.09)
                    }
                    .frame(width: UIScreen.screenWidth)
                }
                VStack {
                    HStack {
                        Text("2023-03-19 (Tue)")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("ddd")
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("2023")
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "dial.min")
                    })
                }
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
