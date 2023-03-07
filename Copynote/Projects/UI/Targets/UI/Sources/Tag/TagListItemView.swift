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
            .font(.body)
            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(Color(hex: tagItem.colorHex))
            .clipShape(RoundedRectangle(cornerSize:  .init(width: 10, height: 10)))
    }
}


struct TagListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TagListItemView(tagItem: .init(id: "1", title: "🥲", colorHex: "#00FF00"))
    }
}
