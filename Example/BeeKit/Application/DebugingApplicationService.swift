//
//  DebugingApplicationService.swift
//  BeeKit_Example
//
//  Created by liuxc on 2021/1/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

#if DEBUG
import DoraemonKit
#endif

class DebugingApplicationService: NSObject, ApplicationService {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        setupTouch()

        setupDoraemonKit()

        return true
    }

    func setupTouch() {
        #if DEBUG
        self.window?.activateTouch()
        #endif
    }

    func setupDoraemonKit() {
        #if DEBUG
        DoraemonManager.shareInstance().addH5DoorBlock { (url) in
            navigator.push(url)
        }
        DoraemonManager.shareInstance().install()
        #endif
    }


}

