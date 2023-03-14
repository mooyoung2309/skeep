//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송영모 on 2023/03/06.
//

import ProjectDescription
import ProjectDescriptionHelpers

let factory: ProjectFactory = .init(
    project: .init(name: Module.application.rawValue),
    targets: [
        .init(
            name: Module.application.rawValue,
            product: .app,
            infoPlist: .extendingDefault(
                with: [
                    "CFBundleShortVersionString": "1.0",
                    "CFBundleVersion": "1",
                    "UILaunchStoryboardName": "LaunchScreen",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": []
                    ],
                    "UIAppFonts": [
                        "Item 0": "Pretendard-Medium.otf",
                        "Item 1": "Pretendard-Regular.otf",
                        "Item 2": "Pretendard-SemiBold.otf",
                        "Item 3": "Pretendard-Bold.otf",
                        "Item 4": "Happiness-Sans-Regular.otf",
                        "Item 5": "Happiness-Sans-SemiBold.otf",
                        "Item 6": "Happiness-Sans-Bold.otf"
                    ]
                ]),
            havResource: true,
            dependencies: [
                .project(target: Module.feature.rawValue, path: Module.feature.path)
            ]
        ),
        .init(
            name: "Keyboard",
            product: .appExtension,
            infoPlist: .extendingDefault(
                with: [
                    "NSExtension": [
                        "NSExtensionAttributes": [
                            "IsASCIICapable": false,
                            "PrefersRightToLeft": false,
                            "PrimaryLanguage": "en-US",
                            "RequestsOpenAccess": false
                        ],
                        "NSExtensionPointIdentifier": "com.apple.keyboard-service",
                        "NSExtensionPrincipalClass": "$(PRODUCT_MODULE_NAME).KeyboardViewController"
                    ],
                    "CFBundleDisplayName": "KeyboardExtension"
                ]),
            dependencies: [
                .project(target: Module.feature.rawValue, path: Module.feature.path),
            ]
        )
    ]
)

let project = factory.makeProject()
