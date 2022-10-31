import Foundation
import UIKit



protocol CoordinatorProtocol {
    var controller: UITabBarController? {get set}


    func eventAction(event: Event, iniciator: UIViewController)
    func start() -> UITabBarController?
}

protocol Coordinated {
    var coordinator: CoordinatorProtocol? {get set}
    
}
