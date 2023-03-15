//
//  File.swift
//  Core
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

struct File {
    var id: String
    var title: String
    var content: String
    var created: Date
    var edited: Date
    var directory: Directory?
}

