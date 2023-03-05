//
//  AppDelegate.swift
//  Copynote
//
//  Created by 송영모 on 2022/12/30.
//  Copyright © 2022 Copynote. All rights reserved.
//

import UIKit

import ComposableArchitecture

class AppDelegate: UIResponder, UIApplicationDelegate {
    let store: Store<AppStore.State, AppStore.Action> = .init(
        initialState: .init(),
        reducer: AppStore()
    )
    
    lazy var viewStore = ViewStore<AppStore.State, AppStore.Action>(store)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        viewStore.send(.onLaunchFinish)
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return false
    }
}
