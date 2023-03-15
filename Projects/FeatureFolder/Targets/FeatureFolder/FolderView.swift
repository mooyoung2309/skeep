//
//  FolderView.swift
//  FeatureFolder
//
//  Created by 송영모 on 2023/03/15.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

public struct FolderView: View {
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            List {
                HStack {
                    Image(systemName: "folder")
                    Text("test")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                HStack {
                    Image(systemName: "folder")
                    Text("test")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                HStack {
                    Image(systemName: "folder")
                    Text("test")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .navigationTitle("Folder")
        }
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView()
    }
}
