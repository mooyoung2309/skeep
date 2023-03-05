//
//  CopynoteApp.swift
//  Copynote
//
//  Created by 송영모 on 2023/03/04.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

@main
struct CopynoteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            WithViewStore(
                appDelegate.store
            ) { viewStore in
                ZStack {
                    EmptyView()
                }
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}
