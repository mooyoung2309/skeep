//
//  MutableCollection+Extension.swift
//  Utils
//
//  Created by 송영모 on 2023/04/12.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

extension MutableCollection {
    subscript(safe index: Index) -> Element? {
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

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
