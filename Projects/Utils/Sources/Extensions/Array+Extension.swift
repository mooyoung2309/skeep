//
//  Array+Extension.swift
//  Utils
//
//  Created by 송영모 on 2023/03/19.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import RealmSwift

extension Array {
//    public subscript (safe index: Int) -> Element? {
//        return indices ~= index ? self[index] : nil
//    }
    
    public subscript(safe index: Int) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }

        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}
