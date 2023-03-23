//
//  FileItemView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/23.
//  Copyright © 2023 Copynote. All rights reserved.
//

import Foundation
import Core

import SwiftUI

struct FileItemView: View {
    let file: File
    
    init(file: File) {
        self.file = file
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(file.title)
                .font(.headline)
            Text(file.content)
                .foregroundColor(.gray)
                .font(.callout)
        }
    }
}
