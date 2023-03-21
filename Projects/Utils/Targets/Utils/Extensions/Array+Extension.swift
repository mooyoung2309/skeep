//
//  Array+Extension.swift
//  Utils
//
//  Created by 송영모 on 2023/03/19.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
