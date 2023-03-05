import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, platform: Platform, additionalTargets: [String]) -> Project {
        var targets = makeAppTargets(name: name,
                                     platform: platform,
                                     dependencies: additionalTargets.map { TargetDependency.target(name: $0) })
        targets += additionalTargets.flatMap({ makeFrameworkTargets(name: $0, platform: platform) })
        return Project(name: name,
                       organizationName: "tuist.io",
                       targets: targets)
    }
    
    // MARK: - Private
    
    /// Helper function to create a framework target and an associated unit test target
    private static func makeFrameworkTargets(name: String, platform: Platform) -> [Target] {
        let sources = Target(name: name,
                             platform: platform,
                             product: .framework,
                             bundleId: "io.tuist.\(name)",
                             infoPlist: .default,
                             sources: ["Targets/\(name)/Sources/**"],
                             resources: [],
                             dependencies: [])
        let tests = Target(name: "\(name)Tests",
                           platform: platform,
                           product: .unitTests,
                           bundleId: "io.tuist.\(name)Tests",
                           infoPlist: .default,
                           sources: ["Targets/\(name)/Tests/**"],
                           resources: [],
                           dependencies: [.target(name: name)])
        return [sources, tests]
    }
    
    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen"
        ]
        
        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "io.tuist.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            dependencies: dependencies
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "io.tuist.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            dependencies: [
                .target(name: "\(name)")
            ])
        return [mainTarget, testTarget]
    }
    
    public static func makeCopynoteFrameworkTargets(
        name: String,
        platform: Platform,
        deploymentTarget: DeploymentTarget,
        dependencies: [TargetDependency]
    ) -> [Target] {
        let sources = Target(
            name: name,
            platform: platform,
            product: .framework,
            bundleId: "com.annapo.\(name)",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Targets/\(name)/Sources/**"],
            resources: [],
            dependencies: dependencies,
            settings: .settings(base: .init())
        )
        
        return [sources]
    }
    
    public static func makeCopynoteExtensionTargets(
        name: String,
        platform: Platform,
        deploymentTarget: DeploymentTarget,
        dependencies: [TargetDependency]
    ) -> [Target] {
        let sources = Target(
            name: name,
            platform: .iOS,
            product: .appExtension,
            bundleId: "com.annapo.Copynote.\(name)",
            deploymentTarget: deploymentTarget,
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
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Sources/**"],
            dependencies: dependencies
        )
        
        return [sources]
    }
    
    public static func makeCopynoteAppTarget(
        platform: Platform,
        dependencies: [TargetDependency],
        deploymentTarget: DeploymentTarget
    ) -> Target {
        let platform = platform
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
        
        return .init(
            name: "Copynote",
            platform: platform,
            product: .app,
            bundleId: "com.annapo.Copynote",
            deploymentTarget: deploymentTarget,
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/App/Sources/**"],
            resources: ["Targets/App/Resources/**"],
            entitlements: "./Copynote.entitlements",
            dependencies: dependencies
        )
    }
}
