import Foundation
import UIKit

enum Event {
    case loginSuccess
    case secondButtonTapped
}

class AppCoordinator: CoordinatorProtocol {
    var controller: UITabBarController?
    var factory: ModuleFactory?
    let storage = PhotoStorage()
    
    var coordinators: [CoordinatorProtocol]?

    
    required init(controller: UITabBarController) {
        self.controller = controller
    }

    func eventAction(event: Event) {
        switch event {
        case .loginSuccess:
            let profileController = self.factory?.makeModule(type: .profile) as? ProfileViewController
            guard let initialController = self.controller?.viewControllers![1] else {return}
            guard let secondVC = profileController else {return}
            initialController.navigationController?.pushViewController(secondVC, animated: false)
        case .secondButtonTapped:
            return
        }
    }

    func start() -> UITabBarController? {
        self.setTabBarController()
        return controller
    }

    func setTabBarController() {
        guard let factory = factory else {
            return
        }
        let tab1 = factory.makeModule(type: .feed) as? FeedViewController
        let tab2 = factory.makeModule(type: .login) as? LoginViewController

        let navTab1 = UINavigationController(rootViewController: tab1!)
        let navTab2 = UINavigationController(rootViewController: tab2!)

        guard let controller = self.controller else {return}
        controller.tabBar.backgroundColor = .white
        controller.viewControllers = [navTab1, navTab2]
        self.controller = controller
    }
}
