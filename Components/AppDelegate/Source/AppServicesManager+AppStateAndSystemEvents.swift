import UIKit

extension ApplicationDelegate {

    @available(iOS 2.0, *)
    open func applicationDidBecomeActive(_ application: UIApplication) {
        for service in _services {
            service.applicationDidBecomeActive?(application)
        }
    }

    @available(iOS 2.0, *)
    open func applicationWillResignActive(_ application: UIApplication) {
        for service in _services {
            service.applicationWillResignActive?(application)
        }
    }

    @available(iOS 4.0, *)
    open func applicationDidEnterBackground(_ application: UIApplication) {
        for service in _services {
            service.applicationDidEnterBackground?(application)
        }
    }

    @available(iOS 4.0, *)
    open func applicationWillEnterForeground(_ application: UIApplication) {
        for service in _services {
            service.applicationWillEnterForeground?(application)
        }
    }

    @available(iOS 2.0, *)
    open func applicationWillTerminate(_ application: UIApplication) {
        for service in _services {
            service.applicationWillTerminate?(application)
        }
    }

    @available(iOS 4.0, *)
    open func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        for service in _services {
            service.applicationProtectedDataWillBecomeUnavailable?(application)
        }
    }

    @available(iOS 4.0, *)
    open func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        for service in _services {
            service.applicationProtectedDataDidBecomeAvailable?(application)
        }
    }

    @available(iOS 2.0, *)
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        for service in _services {
            service.applicationDidReceiveMemoryWarning?(application)
        }
    }

    @available(iOS 2.0, *)
    open func applicationSignificantTimeChange(_ application: UIApplication) {
        for service in _services {
            service.applicationSignificantTimeChange?(application)
        }
    }
}
