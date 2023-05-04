import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.App.name,
    targets: [
        .app(
            implements: .IOS,
            factory: .init(
                infoPlist: .extendingDefault(
                    with: [
                        "CFBundleShortVersionString": "1.0",
                        "CFBundleVersion": "1",
                        "UILaunchStoryboardName": "LaunchScreen",
                        "UIApplicationSceneManifest": [
                            "UIApplicationSupportsMultipleScenes": false,
                            "UISceneConfigurations": []
                        ]
                    ]
                ),
                dependencies: [
                    .feature
                ]
            )
        )
    ]
)
