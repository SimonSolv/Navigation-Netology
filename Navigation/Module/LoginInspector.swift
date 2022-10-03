import Foundation
class LoginInspector: LoginViewControllerDelegate {

    func checkPswd(login: String, password: String) -> Bool {
        if (login + password).hashValue == Checker.shared.check() {
            print("Accepted")
            return true
        } else {
            print("Denied")
            return false
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
