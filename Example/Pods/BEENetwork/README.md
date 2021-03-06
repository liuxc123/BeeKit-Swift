# BEENetwork

[![CI Status](https://img.shields.io/travis/liuxc123/BEENetwork.svg?style=flat)](https://travis-ci.org/liuxc123/BEENetwork)
[![Version](https://img.shields.io/cocoapods/v/BEENetwork.svg?style=flat)](https://cocoapods.org/pods/BEENetwork)
[![License](https://img.shields.io/cocoapods/l/BEENetwork.svg?style=flat)](https://cocoapods.org/pods/BEENetwork)
[![Platform](https://img.shields.io/cocoapods/p/BEENetwork.svg?style=flat)](https://cocoapods.org/pods/BEENetwork)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 9.0
* Swift 5.0
* Xcode 11

## Installation

BEENetwork is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BEENetwork'
```

## Usage

Do not use cache
```swift
NetworkManager.default.provider
    .rx
    .request(MultiTarget(Api.category))
    .asObservable().distinctUntilChanged()
    .map(BaseModel<ListData>.self)
    .map {$0.data.list}
    .subscribe(onNext: { (list) in
        self.items = list
        self.tableView.reloadData()
    }, onError: { (e) in
        print(e.localizedDescription)
    }).disposed(by: dispose)
```
Or you can use TargetType to request directly
```swift
Api.category.request()
    .map(BaseModel<ListData>.self)
    .map { $0.data.list }
    .subscribe(onSuccess: { (list) in
        self.items = list
        self.tableView.reloadData()
    }) { (e) in
        print(e.localizedDescription)
}.disposed(by: dispose)
```
Use cache
```swift
NetworkManager.default.provider
    .rx
    .onCache(MultiTarget(Api.category))
    .distinctUntilChanged()
    .map(BaseModel<ListData>.self)
    .map {$0.data.list}
    .subscribe(onNext: { (list) in
        self.items = list
        self.tableView.reloadData()
    }, onError: { (e) in
        print(e.localizedDescription)
    }).disposed(by: dispose)
    
/// or

Api.category.cache()
    .distinctUntilChanged()
    .map(BaseModel<ListData>.self)
    .map { $0.data.list }
    .subscribe(onNext: { (model) in
        print(model.first?.name ?? "")
        self.items = model
        self.tableView.reloadData()
    }, onError: { (e) in
        print(e.localizedDescription)
    }).disposed(by: dispose)
```
You can also customize the use of the plugin
```swift
let configuration = Configuration()
configuration.plugins.append(LoggingPlugin())
let manager = NetworkManager(configuration: configuration)
manager.provider
    .rx
    .request(MultiTarget(Api.category))
    .asObservable().distinctUntilChanged()
    .map(BaseModel<ListData>.self)
    .map {$0.data.list}
    .subscribe(onNext: { (list) in
        self.items = list
        self.tableView.reloadData()
    }, onError: { (e) in
        print(e.localizedDescription)
    }).disposed(by: dispose)
```

## Author

liuxc123, lxc_work@126.com

## License

BEENetwork is available under the MIT license. See the LICENSE file for more info.
