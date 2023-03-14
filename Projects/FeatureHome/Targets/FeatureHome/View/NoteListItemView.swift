//
//  NoteItemView.swift
//  UI
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

public struct NoteListItemView: View {
    let noteItem: NoteItem
    
    public init(noteItem: NoteItem) {
        self.noteItem = noteItem
    }
    
    public var body: some View {
        HStack {
            if let tagItem = self.noteItem.tag {
                TagListItemView(tagItem: tagItem)
                    .padding()
                    .padding(.vertical)
            }
            
            VStack(alignment: .leading) {
                Text(noteItem.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.init(top: .zero, leading: .zero, bottom: 1, trailing: .zero))
                
                Text(noteItem.content)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .background(.white)
    }
}


struct NoteListItemView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListItemView(noteItem: .init(id: "dd", title: "타이틀", content: "컨텐츠"))
    }
}
