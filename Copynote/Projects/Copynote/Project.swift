import ProjectDescription

protocol ProjectFactory {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }

    func generateTarget() -> [Target]
    func generateConfigurations() -> Settings
}

// MARK: - Base Project Factory
class BaseProjectFactory: ProjectFactory {
    let projectName: String = "Copynote"

    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ]
                ]
            ]
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
    ]

    let dependencies: [TargetDependency] = [
        .external(name: "Moya"),
        .external(name: "ComposableArchitecture"),
        .external(name: "RealmSwift"),
        .external(name: "Realm"),
    ]

    func generateConfigurations() -> Settings {
        Settings.settings(configurations: [
            .debug(name: "Debug", xcconfig: .relativeToCurrentFile("Copynote/Sources/Config/Debug.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToCurrentFile("Copynote/Sources/Config/Release.xcconfig"))
        ])
    }

    func generateTarget() -> [Target] {
        [
            Target(
                name: projectName,
                platform: .iOS,
                product: .app,
                bundleId: "com.annapo.\(projectName)",
                deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["Copynote/Sources/**"],
                resources: "Copynote/Resources/**",
                entitlements: "Copynote/\(projectName).entitlements",
                dependencies: [
                    .external(name: "Moya"),
                    .external(name: "ComposableArchitecture"),
                    .external(name: "RealmSwift"),
                    .external(name: "Realm"),
                    .target(name: "KeyboardExtension")
                ]
            ),
            
            Target(
                name: "KeyboardExtension",
                platform: .iOS,
                product: .appExtension,
                bundleId: "com.annapo.Copynote.KeyboardExtension",
                deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
                infoPlist: .extendingDefault(with: [
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
                sources: ["KeyboardExtension/Sources/**"],
                resources: "KeyboardExtension/Resources/**",
                dependencies: dependencies
            ),
        ]
    }
}

// MARK: - Project
let factory = BaseProjectFactory()

let project: Project = .init(
    name: factory.projectName,
    organizationName: factory.projectName,
    settings: factory.generateConfigurations(),
    targets: factory.generateTarget()
)
