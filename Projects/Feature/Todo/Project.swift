import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name + ModulePath.Feature.Todo.rawValue,
    targets: [
        .feature(
            interface: .Todo,
            factory: .init()
        ),
        .feature(
            implements: .Todo,
            factory: .init(
                dependencies: [
                    .feature(interface: .Todo)
                ]
            )
        ),
        .feature(
            testing: .Todo,
            factory: .init(
                dependencies: [
                    .feature(interface: .Todo)
                ]
            )
        ),
        .feature(
            tests: .Todo,
            factory: .init(
                dependencies: [
                    .feature(testing: .Todo)
                ]
            )
        ),
        .feature(
            example: .Todo,
            factory: .init(
                dependencies: [
                    .feature(interface: .Todo)
                ]
            )
        )
    ]
)
