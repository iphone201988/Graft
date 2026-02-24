import UIKit

class ConnectYourContactsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white.withAlphaComponent(0.98)
    }
    
    @IBAction func googleConnect(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func iCloudConnect(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func outlookConnect(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func skipForNow(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
