import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name + ModulePath.Feature.Memo.rawValue,
    targets: [    
        .feature(
            interface: .Memo,
            factory: .init()
        ),
        .feature(
            implements: .Memo,
            factory: .init(
                dependencies: [
                    .feature(interface: .Memo)
                ]
            )
        ),
        .feature(
            testing: .Memo,
            factory: .init(
                dependencies: [
                    .feature(interface: .Memo)
                ]
            )
        ),
        .feature(
            tests: .Memo,
            factory: .init(
                dependencies: [
                    .feature(testing: .Memo)
                ]
            )
        ),
        .feature(
            example: .Memo,
            factory: .init(
                dependencies: [
                    .feature(interface: .Memo)
                ]
            )
        )
    ]
)
