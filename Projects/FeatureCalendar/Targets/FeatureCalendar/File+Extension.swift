//
//  File+Extension.swift
//  FeatureCalendar
//
//  Created by 송영모 on 2023/04/05.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core
import Utils
import UIKit

extension File {
    func isHead(date: Date) -> Bool {
        return startDate.isDate(inSameDayAs: date)
    }
    
    func offset(date: Date, index: Int) -> CGSize {
        if self.term > 1 {
            return .init(width: (UIScreen.screenWidth - 20.0) / 7.0 / 2.0 * CGFloat(term - 1), height: UIScreen.screenHeight * 0.08 / 5.0 * CGFloat(index))
        } else {
            return .init(width: 0.0, height: UIScreen.screenHeight * 0.08 / 5.0 * CGFloat(index))
        }
    }
    
    var term: Int {
        return startDate.day(to: endDate)
    }
    
    var width: CGFloat {
        return (UIScreen.screenWidth - 20.0) / 7.0 * CGFloat(startDate.day(to: endDate))
    }
}
