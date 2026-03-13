import UIKit

class CreateLogInteractionVC: UIViewController {
    
    @IBOutlet weak var chooseTypeTF: OpenSansTF!
    @IBOutlet weak var subjectTV: OpenSansTV!
    @IBOutlet weak var noteTV: OpenSansTV!
    
    var sources = [["tag": "Email", "icon": "Frame 258"],
                   ["tag": "Phone Call", "icon": "Frame 259"],
                   ["tag": "Message/SMS", "icon": "Frame 257"],
                   ["tag": "WhatsApp", "icon": "Frame 257"],
                   ["tag": "iMessage", "icon": "Frame 257"],
                   ["tag": "Video Call", "icon": "Frame 256"],
                   ["tag": "Meeting", "icon": "Frame 255"]]
    
    var sourcePopupView: TagPopupView?
    var selectedSource: [String: Any] = ["tag": "Email", "icon": "Frame 258"]
    var servicesEvents: ServicesEvents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray.withAlphaComponent(0.9)
        chooseTypeTF.text = "Email"
    }
    
    @IBAction func closeForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func createTag(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
            let createdAt = formatter.string(from: date)
            let details =
            NewAddingInfo(
                interactionType: self?.chooseTypeTF.text,
                interactionSubject: self?.subjectTV.text,
                interactionNote: self?.noteTV.text,
                interactionCreatedAt: createdAt,
                interactionIcon: self?.selectedSource["icon"] as? String
            )
            
            self?.servicesEvents?.createdLogInteraction(info: details)
        }
    }
    
    @IBAction func chooseSource(_ sender: UIButton) {
        if sourcePopupView != nil {
            sourcePopupView?.removeFromSuperview()
            sourcePopupView = nil
            return
        }
        
        let popup = TagPopupView()
        popup.tags = sources
        popup.selectedTag = selectedSource
        popup.backgroundColor = .orange
        
        popup.didSelectTag = { [weak self] tag in
            guard let self = self else { return }
            self.selectedSource = tag
            self.sourcePopupView?.removeFromSuperview()
            self.sourcePopupView = nil
            let tagName = selectedSource["tag"] as? String ?? ""
            chooseTypeTF.text = tagName
        }
        
        view.addSubview(popup)
        popup.translatesAutoresizingMaskIntoConstraints = false
        let width = UIScreen.main.bounds.width - 88
        NSLayoutConstraint.activate([
            popup.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: 8),
            popup.leadingAnchor.constraint(equalTo: sender.leadingAnchor),
            popup.widthAnchor.constraint(equalToConstant: width),
            popup.heightAnchor.constraint(equalToConstant: 330)
        ])
        
        sourcePopupView = popup
    }
}
