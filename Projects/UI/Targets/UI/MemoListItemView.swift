//
//  MemoListItemView.swift
//  UI
//
//  Created by 송영모 on 2023/03/29.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core

public struct MemoItemView: View {
    let file: File
    
    public init(file: File) {
        self.file = file
    }
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text(file.title)
                .font(.headline)
            Text(file.content)
                .foregroundColor(.gray)
                .font(.callout)
        }
    }
}
