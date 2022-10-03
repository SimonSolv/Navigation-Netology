import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        self.title = "Info"
        let alertButton = UIButton(frame: CGRect(x: view.bounds.width/2-100, y: 200, width: 200, height: 100))
        alertButton.setTitle("File", for: .normal )
        alertButton.addTarget(self, action: #selector(tapAlertButton), for: .touchUpInside)
        view.addSubview(alertButton)
    }
    @objc func tapAlertButton() {
        let alertVC = UIAlertController(title: "Ошибка", message: "Невозможно прочитать файл", preferredStyle: .alert )
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: {(_: UIAlertAction!) in print("Ok Action")})
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: {(_: UIAlertAction!) in print("Cancel Action")})
        alertVC.addAction(cancelAction)
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}
