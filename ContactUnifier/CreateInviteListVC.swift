import UIKit

class CreateInviteListVC: UIViewController {
    
    @IBOutlet weak var listName: OpenSansTF!
    @IBOutlet weak var listDesc: OpenSansTV!
    
    var servicesEvents: ServicesEvents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray.withAlphaComponent(0.9)
    }
    
    @IBAction func closeForm(_ sender: UIButton) {
        let name = listName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let desc = listDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if name.isEmpty {
            Toast.show(message: "List name is required")
            return
        }
        dismiss(animated: true) { [weak self] in
            self?.servicesEvents?.createdList(listName: name, listDesc: desc)
        }
    }
    
    @IBAction func createList(_ sender: UIButton) {
        let name = listName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let desc = listDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if name.isEmpty {
            Toast.show(message: "List name is required")
            return
        }
        dismiss(animated: true) { [weak self] in
            self?.servicesEvents?.createdList(listName: name, listDesc: desc)
        }
    }
}
