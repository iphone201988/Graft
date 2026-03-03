import UIKit

class CompleteContactInfoVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray.withAlphaComponent(0.9)
    }
    
    @IBAction func closeForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func cancelForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func saveForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
