import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let appConfiguration = AppConfiguration.allCases.randomElement()!
        NetworkService.request(for: appConfiguration)
        
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        let initialController = UITabBarController()
        let coordinator = AppCoordinator(controller: initialController)
        
        let factory = ModuleFactory()
        coordinator.factory = factory
        factory.coordinator = coordinator


        window?.rootViewController = coordinator.start()!
    }
    
}
