import Foundation
import UIKit
import FirebaseAuth

class LoginInspector: LoginViewControllerDelegate {
    func checkCredentials(email: String, password: String, iniciator: LoginViewController) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error != nil {
                let alertVC = UIAlertController(title: "Warning:", message: error!.localizedDescription, preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(_: UIAlertAction!) in
                })
                alertVC.addAction(okAction)
                iniciator.present(alertVC, animated: true)
                return
            }
            if error?.localizedDescription == nil {
                iniciator.coordinator?.eventAction(event: .loginSuccess, iniciator: iniciator)
            }
        }
    }
    

    func checkPswd(login: String, password: String) -> Bool {
        if (login + password).hashValue == Checker.shared.check() {
            print("Accepted")
            return true
        } else {
            print("Denied")
            return false
        }
    }
    
    func signUp(login: String, password: String, iniciator: UIViewController) {
        Auth.auth().createUser(withEmail: login, password: password) { authResult, error in
            if error != nil {
                let alertVC = UIAlertController(title: "Warning:", message: error!.localizedDescription, preferredStyle: .alert )
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(_: UIAlertAction!) in
                })
                alertVC.addAction(okAction)
                iniciator.present(alertVC, animated: true)
                return
            } else {
                print(authResult?.user.refreshToken)
                print(authResult?.user.email)
            }
            let alertVC = UIAlertController(title: "Success!", message: "You have been signed in", preferredStyle: .alert )
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(_: UIAlertAction!) in
                iniciator.dismiss(animated: true)
            })
            alertVC.addAction(okAction)
            iniciator.present(alertVC, animated: true)
        }
    }
}
protocol LoginFactory {
    func factory() -> LoginInspector
}

class MyLoginFactory: LoginFactory {
    func factory() -> LoginInspector {
        let factory = LoginInspector()
        return factory
    }
}
