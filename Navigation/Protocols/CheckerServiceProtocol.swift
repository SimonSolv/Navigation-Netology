import Foundation
import UIKit

protocol CheckerServiceProtocol {
    func signUp(login: String, password: String, iniciator: UIViewController)
    func checkCredentials(email: String, password: String, iniciator: LoginViewController)
}
