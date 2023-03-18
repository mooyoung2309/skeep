//
//  MemoEditView.swift
//  FeatureMemo
//
//  Created by 송영모 on 2023/03/18.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI
import Core

import ComposableArchitecture

struct MemoEditView: View {
    @State private var someBinding = true
    let store: StoreOf<MemoEdit>
    
    init(file: File) {
        self.store = .init(initialState: .init(file: file), reducer: MemoEdit()._printChanges())
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                TextField(
                    "Title",
                    text: viewStore.binding(get: \.file.title, send: MemoEdit.Action.textFieldChanged)
                )
                .font(.title)
                .bold()
                
                TextEditor(
                    text: viewStore.binding(get: \.file.content, send: MemoEdit.Action.textEditorChanged)
                )
                .frame(minHeight: 100)
            }
            .sheet(isPresented: viewStore.binding(get: \.isSheetPresented, send: MemoEdit.Action.setSheet(isPresented:))) {
                VStack(alignment: .leading) {
                    HStack {
                        Label("", systemImage: "paintpalette")
                        
                        ScrollView(.horizontal) {
                            HStack(alignment: .center) {
                                Spacer()
                                ForEach(ColorPalette.allCases, id: \.rawValue) { colorPalette in
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "circle.fill")
                                            .resizable()
                                            .foregroundColor(colorPalette.pickerColor)
                                            .frame(width: 25, height: 25)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding()
                    
                    HStack {
                        Label("", systemImage: "clock")
                        
                        VStack(alignment: .leading) {
                            Text("03-18 (Tue)")
                                .font(.subheadline)
                                .fontWeight(.light)
                            
                            Text("5:00 PM")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Image(systemName: "chevron.right")
                        
                        VStack(alignment: .leading) {
                            Text("03-18 (Tue)")
                                .font(.subheadline)
                                .fontWeight(.light)
                            
                            Text("5:00 PM")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                        
                        Toggle("All Day", isOn: $someBinding)
                            .toggleStyle(.button)
                    }
                    .padding()
                    
                    HStack {
                        Label("", systemImage: "face.dashed")
                        
                        Toggle("Add To-Do List", isOn: $someBinding)
                            .toggleStyle(.switch)
                    }
                    .padding()
                    
                    Spacer()
                }
                .presentationDetents([.medium])
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewStore.send(.setSheet(isPresented: true))
                    }, label: {
                        Label("", systemImage: "sun.min")
                    })
                }
            }
        }
    }
}
