//
//  HabitView.swift
//  FeatureHabit
//
//  Created by 송영모 on 2023/03/26.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Utils

public struct HabitView: View {
    public init() {}
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: .init(repeating: .init(), count: 7)) {
                ForEach(Calendar.current.shortStandaloneWeekdaySymbols, id: \.hashValue) { week in
                    Text(week)
                        .font(.subheadline)
                }
            }
            
            Spacer()
        }
        .navigationTitle("Habit")
    }
}
