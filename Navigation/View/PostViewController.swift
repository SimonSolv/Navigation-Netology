import UIKit

class PostViewController: UIViewController {
    var titleName: String?
        override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        let infoButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(infoTap))
        navigationItem.rightBarButtonItem = infoButton
        self.title = titleName
    }
    @objc func infoTap() {
        let controller = InfoViewController()
        self.present(controller, animated: true, completion: nil)
    }

}
