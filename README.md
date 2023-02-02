# Copynote
Copynote iOS repository

## Config

Tuist와 ReactorKit을 사용하였습니다.

### Tuist workspace summary
- Projects (single target)
  - Copynote
```swift
// Workspace.swift
import ProjectDescription

let appName = "Copynote"
let workspace = Workspace(name: appName, projects: ["Projects/*"])
```

### Project directory summary
- Source
  - Base (base files)
  - Config (xxconfig files)
  - Extension (extension files)
  - Model (model files)
  - Presenter (screen files)
  - Provider (singleton layers)
  - Service (business layers)
- AppDelegate.swift
- SceneDelegate.swift
- CompositionRoot.swift

## Convention

## 

## Library
|라이브러리명|버전|링크|비고|
|---|---|---|---|
|Tuist|3.15.0|[site](https://tuist.io)||
|ReactorKit|upToNextMinor(3.2.0)|[github](https://github.com/ReactorKit/ReactorKit)||
|RxSwift|upToNextMinor(6.5.0)|[github](https://github.com/ReactiveX/RxSwift)||
|Moya|upToNextMinor(15.0.0)|[github](https://github.com/Moya/Moya)||
|SnapKit|upToNextMinor(5.0.0)|[github](https://github.com/SnapKit/SnapKit)||
|RealmSwift|10.31.0|[github](https://github.com/realm/realm-swift)|Version Error For Using Carthage|
|KeychainAccess|4.2.2|[github](https://github.com/kishikawakatsumi/KeychainAccess)||
|RxGesture|upToNextMinor(4.0.0)|[github](https://github.com/RxSwiftCommunity/RxGesture)||
|RxDataSources|upToNextMinor(5.0.0)|[github](https://github.com/RxSwiftCommunity/RxDataSources)||
