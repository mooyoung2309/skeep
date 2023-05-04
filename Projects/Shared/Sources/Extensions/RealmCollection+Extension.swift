//
//  RealmCollection+Extension.swift
//  Utils
//
//  Created by 송영모 on 2023/03/26.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import RealmSwift

extension RealmCollection {
    func toArray<T>() -> [T] {
        return self.compactMap { $0 as? T }
    }
}
