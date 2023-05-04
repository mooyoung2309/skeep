import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name + ModulePath.Feature.Calendar.rawValue,
    targets: [
        .feature(
            interface: .Calendar,
            factory: .init()
        ),
        .feature(
            implements: .Calendar,
            factory: .init(
                dependencies: [
                    .feature(interface: .Calendar)
                ]
            )
        ),
        .feature(
            testing: .Calendar,
            factory: .init(
                dependencies: [
                    .feature(interface: .Calendar)
                ]
            )
        ),
        .feature(
            tests: .Calendar,
            factory: .init(
                dependencies: [
                    .feature(testing: .Calendar)
                ]
            )
        ),
        .feature(
            example: .Calendar,
            factory: .init(
                dependencies: [
                    .feature(interface: .Calendar)
                ]
            )
        )
    ]
)
