//
//  NoteItemView.swift
//  UI
//
//  Created by 송영모 on 2023/03/07.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import Core

public struct NoteListItemView: View {
    let note: Note
    
    public init(note: Note) {
        self.note = note
    }
    
    public var body: some View {
        HStack {
            if let tag = self.note.tag {
                TagListItemView(tag: tag)
                    .padding()
                    .padding(.vertical)
            }
            
            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.init(top: .zero, leading: .zero, bottom: 1, trailing: .zero))
                
                Text(note.content)
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
        NoteListItemView(note: .init(id: "dd", title: "타이틀", content: "컨텐츠"))
    }
}
