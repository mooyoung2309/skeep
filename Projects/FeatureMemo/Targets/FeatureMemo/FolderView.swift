//
//  FolderView.swift
//  FeatureFolder
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core

struct FolderItemView: View {
    var directory: Directory
    
    var body: some View {
        HStack {
            Image(systemName: "folder")
            Text(directory.title)
            Spacer()
        }
    }
}

public struct FolderView: View {
    public init() {}
    
    public var body: some View {
        NavigationView {
            List {

            }
        }
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}
