//
//  ToDoStyle.swift
//  Core
//
//  Created by 송영모 on 2023/03/20.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation

import RealmSwift

public enum ToDoStyle: Int, PersistableEnum {
    case `default`
    case hidden
    case week
}
