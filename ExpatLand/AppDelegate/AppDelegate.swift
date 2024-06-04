//
//  AppDelegate.swift
//  ExpatLand
//
//  Created by User on 01/12/21.
//

import UIKit
import PushNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate {

    let pushNotifications = PushNotifications.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.pushNotifications.start(instanceId: "cde52dbe-d4c9-4fa2-a541-4ed0114c27f7")
        self.pushNotifications.registerForRemoteNotifications()
        UNUserNotificationCenter.current().delegate = self
   //     UIApplication.shared.applicationIconBadgeNumber = 0
      
        //   try? self.pushNotifications.addDeviceInterest(interest: "hello")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Constants.userDefaults.set(deviceToken, forKey: UserDefaultKeys.notificationToken)
        guard Constants.userDefaults.getNotificationStatus() == 1 else { return }
        self.pushNotifications.registerDeviceToken(deviceToken)
        
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
       //  self.pushNotifications.handleNotification(userInfo: userInfo)
        print("harshit" , userInfo)
        NotificationCenter.default.post(name: Notification.Name(rawValue: ServerKeys.notification), object: nil)
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Decide how the notification (that was received in the foreground)
        // should be presented to the user
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.handleNotificationTap(userInfo: response.notification.request.content.userInfo)
        completionHandler()
    }
    
    


    func moveToOpeningScreen() {
        let controller = OpeningScreenVC.instantiate(fromAppStoryboard: .onboarding)
        let navC = UINavigationController(rootViewController: controller)
        navC.navigationBar.isHidden = true
        UIApplication.shared.windows.first?.rootViewController = navC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }

    func logOut(){
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.moveToOpeningScreen()
       
    }
}


extension AppDelegate {
    
    func handleNotificationTap(userInfo: [AnyHashable: Any])
    {
    
      
        UIApplication.dismissAnyAlertControllerIfPresent()
        guard
            let aps = userInfo[AnyHashable("aps")] as? NSDictionary,
            let data = aps["data"] as? NSDictionary,
            let groupId = data["group_id"] as? Int
        else {
            // handle any error here
            return
        }
       
        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: false , completion: nil)
       let nc = UIApplication.shared.windows.first?.rootViewController as? UINavigationController
//        nc?.dismiss(animated: false, completion: nil)
        if UIApplication.topViewController() is  ChatVC {

            nc?.popViewController(animated: false)
            print("called check ")
        }
        
        let vc = ChatVC.instantiate(fromAppStoryboard: .dashboard)
        vc.groupId =  groupId
        vc.refreshDelegate = self
        vc.hidesBottomBarWhenPushed = true
        nc?.pushViewController(vc, animated: true)
        
    }
}

extension AppDelegate: RefreshDegegate{
    
    func refresh() {
        let nc = UIApplication.shared.windows.first?.rootViewController as? SwipeableNavigationController
        let rootVc = nc?.viewControllers.first as? MainTabBarController
        rootVc?.selectedIndex = 1
    }
    
}
