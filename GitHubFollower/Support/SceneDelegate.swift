//
//  SceneDelegate.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 22/12/24.
//
////1. **********What SceneDelegate Does - The SceneDelegate ensures each window has its own lifecycle and user interface.
//The SceneDelegate handles scene-specific events, such as setting up and managing the app's user interface. In apps that support multiple windows (on iPadOS or macOS), each window has its own SceneDelegate instance.
//
//The method scene(_:willConnectTo:options:) is called when the system creates or re-connects a scene. It's where you typically set up the app's window and root view controller.
//
////******2. Code Breakdown
//guard let windowScene = (scene as? UIWindowScene) else { return }
//Ensures the provided scene is of type UIWindowScene, which represents a scene capable of displaying a window. If it isn’t, the method exits early.
//window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//Initializes a new UIWindow with the same size as the UIWindowScene bounds. This creates the actual window where your app's views will be displayed.
//window?.windowScene = windowScene
//Associates the window with the current UIWindowScene. This step is necessary to let the system know which scene the window belongs to.
//window?.rootViewController = ViewController()
//Sets the initial view controller (ViewController) as the root view controller of the window. This is the entry point for your app's interface and dictates what the user sees first.
//window?.makeKeyAndVisible()
//Makes the window the key window, meaning it receives user interactions. It also makes the window visible on the screen.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
       
        
        
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene         = windowScene
        window?.rootViewController  = GFTabBarController() // this tab bar controller holds the navigationa controller and the navigation controller will hold viewcontroller
        window?.makeKeyAndVisible()
        configurenavvigationBar()
        
    }
    
    
    func configurenavvigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
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


}

