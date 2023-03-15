# Copynote
Copynote iOS repository

SwiftUI + TCA 를 사용합니다.

## Tuist
<p align="center">
<img src="https://user-images.githubusercontent.com/77970826/225245091-c86d269f-72a0-4a24-b7f1-848168d2a34a.png">
</p>

Tuist 모듈화는 다음과 같이 진행했습니다. 많이 참고한 영상은 [if(kakao)dev](https://www.youtube.com/watch?v=9HywMpgf8Mk)입니다.

### Tuist + ProjectFactory

Project의 생성을 돕는 구조체를 선언하여 사용합니다. 
자세한 파일들은 ProjectDescriptionHelpers 안에서 확인 가능합니다.

```swift
public struct ProjectFactory {
    var project: ProjectItem
    var targets: [TargetItem]
    
    public init(project: ProjectItem, targets: [TargetItem]) {
        self.project = project
        self.targets = targets
    }
    
    public func makeProject() -> Project {
        return .init(
            name: project.name,
            organizationName: project.organizationName,
            packages: project.packages,
            settings: project.settings,
            targets: targets.map { item in
                return Target.make(
                    appName: project.organizationName,
                    targetName: item.name,
                    platform: item.platform,
                    product: item.product,
                    deploymentTarget: item.deploymentTarget,
                    havResource: item.havResource,
                    infoPlist: item.infoPlist,
                    dependencies: item.dependencies
                )
            }
        )
    }
}

```

## Library
|라이브러리명|버전|링크|비고|
|---|---|---|---|
|Tuist|3.15.0|[site](https://tuist.io)||
