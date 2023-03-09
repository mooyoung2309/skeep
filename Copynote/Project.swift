//import ProjectDescription
//import ProjectDescriptionHelpers
//import MyPlugin
//
////private enum Module: CaseIterable {
////    case keyboard
////    case core
////    case featApp
////    case featKeyboard
////    
////    var moduleName: String {
////        switch self {
////        case .keyboard: return "Keyboard"
////        case .core: return "Core"
////        case .featApp: return "FeatApp"
////        case .featKeyboard: return "FeatKeyboard"
////        }
////    }
////}
//
//private let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "15.0", devices: [.iphone])
//
//func makeConfig() -> Settings {
//    Settings.settings(configurations: [
//        .debug(
//            name: "Debug",
//            xcconfig: .relativeToRoot("Targets/App/Config/Debug.xcconfig")
//        ),
//        .release(
//            name: "Release",
//            xcconfig: .relativeToRoot("Targets/App/Config/Release.xcconfig")
//        )
//    ])
//}
//
//let project: Project = .init(
//    name: "Copynote",
//    organizationName: "Copynote",
//    settings: makeConfig(),
//    targets: [
//        [Project.makeCopynoteAppTarget(
//            platform: .iOS,
//            dependencies: [
//                .target(name: Module.featApp.moduleName),
//                .target(name: Module.keyboard.moduleName)
//            ],
//            deploymentTarget: deploymentTarget)],
//        
//        Project.makeCopynoteExtensionTargets(
//            name: Module.keyboard.moduleName,
//            platform: .iOS,
//            deploymentTarget: deploymentTarget,
//            dependencies: [
//                .target(name: Module.featKeyboard.moduleName)
//            ]),
//        
//        Project.makeCopynoteFrameworkTargets(
//            name: Module.featApp.moduleName,
//            platform: .iOS,
//            deploymentTarget: deploymentTarget,
//            dependencies: [
//                .target(name: Module.core.moduleName),
//            ]),
//        
//        Project.makeCopynoteFrameworkTargets(
//            name: Module.featKeyboard.moduleName,
//            platform: .iOS,
//            deploymentTarget: deploymentTarget,
//            dependencies: [
//                .target(name: Module.core.moduleName),
//            ]),
//        
//        Project.makeCopynoteFrameworkTargets(
//            name: Module.core.moduleName,
//            platform: .iOS,
//            deploymentTarget: deploymentTarget,
//            dependencies: [
//                .external(name: "ComposableArchitecture"),
//                .external(name: "Realm"),
//                .external(name: "RealmSwift"),
//            ]),
//    ].flatMap { $0 }
//)
