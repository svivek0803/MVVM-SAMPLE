//
//  SceneDelegate.swift
//  ExpatLand
//
//  Created by User on 01/12/21.
//

import UIKit
import IQKeyboardManager
import Firebase




class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    static var shared: AppDelegate? = UIApplication.shared.delegate as? AppDelegate


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
       
        guard let _ = (scene as? UIWindowScene) else { return }
        IQKeyboardManager.shared().isEnabled = true
        FirebaseApp.configure()
        checkSignIn()
        navigateToDeepLinkScreen(urlContexts: connectionOptions.urlContexts)

//        let vc = UIStoryboard.init(name: "Dashboard", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
//        window?.rootViewController = vc
//        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        navigateToDeepLinkScreen(urlContexts: URLContexts)
    }

}

extension SceneDelegate
{
    func addResetPasswordDeepLinkAction(token:String)
    {
        let vc = ResetPasswordVC.instantiate(fromAppStoryboard: .onboarding)
        vc.token = token
        vc.navigationType = .deepLink
        let nc = self.window?.rootViewController as? UINavigationController
        nc?.pushViewController(vc, animated: true)
        
    }
    
    func addVerifyEmailDeepLinkAction(token:String)
    {
        let vc = UserSignInVC.instantiate(fromAppStoryboard: .onboarding)
        vc.token = token
        let nc = self.window?.rootViewController as? UINavigationController
        nc?.pushViewController(vc, animated: true)
        
    }
    
    func checkSignIn()
    {
        UIApplication.shared.applicationIconBadgeNumber = 0
        if Constants.userDefaults.isLoggedIn()
        {
            let vc = MainTabBarController.instantiate(fromAppStoryboard: .dashboard)
            let nc = SwipeableNavigationController(rootViewController: vc)
            nc.setNavigationBarHidden(true, animated: false)
            window?.rootViewController = nil
            window?.rootViewController = nc
            window?.makeKeyAndVisible()
        }
        else {
            let vc = OpeningScreenVC.instantiate(fromAppStoryboard: .onboarding)
            let nc = SwipeableNavigationController(rootViewController: vc)
            nc.setNavigationBarHidden(true, animated: false)
            window?.rootViewController = nil
            window?.rootViewController = nc
            window?.makeKeyAndVisible()
        }
    }
    
    func navigateToDeepLinkScreen(urlContexts:Set<UIOpenURLContext>)
    {
        if let url = urlContexts.first?.url {
            if url.absoluteString.contains(ServerKeys.newPassword) {
                guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                      let params = components.queryItems else {
                    return
                }
                
                if let token = params.first(where: { $0.name == ServerKeys.token })?.value {
                    addResetPasswordDeepLinkAction(token: token)
                }
                
            }
            else if url.absoluteString.contains(ServerKeys.emailVerify) {
                guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                      let params = components.queryItems else {
                    return
                }
                
                if let token = params.first(where: { $0.name == ServerKeys.token })?.value {
                    addVerifyEmailDeepLinkAction(token: token)
                    
                    
                }
            }
            
        }
    }
}
