//
//  TagListItemView.swift
//  UI
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core
import Utils

public struct TagListItemView: View {
    let tagItem: TagItem
    
    public init(tagItem: TagItem) {
        self.tagItem = tagItem
    }
    
    public var body: some View {
        Text(tagItem.title)
            .font(.title2)
            .padding(.init(top: 12, leading: 12, bottom: 12, trailing: 12))
            .background(Color(hex: tagItem.colorHex))
            .clipShape(RoundedRectangle(cornerSize:  .init(width: 15, height: 16)))
    }
}


struct TagListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TagListItemView(tagItem: .init(id: "1", title: "🥲", colorHex: "#00FF00"))
    }
}
