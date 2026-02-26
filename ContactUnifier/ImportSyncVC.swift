import UIKit
import SideMenu

class ImportSyncVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerCellFromNib(cellID: ConnectedSourceCell.identifier)
        }
    }
    
    @IBOutlet weak var syncIPhoneLbl: OpenSansLbl!
    @IBOutlet weak var syncIPhoneViewTop: UIView!
    @IBOutlet weak var syncIPhoneView: UIView!
    @IBOutlet weak var hideShowSyncIPhoneViewBtn: UIButton!
    @IBOutlet weak var runExportScriptLbl: OpenSansLbl!
    @IBOutlet weak var uploadCSV: OpenSansLbl!
    
    
    @IBOutlet weak var iMessageViewTop: UIView!
    @IBOutlet weak var iMessageView: UIView!
    @IBOutlet weak var iMessageViewBtn: UIButton!
    
    let sources: [[String: Any]] = [
        
        [
            "name": "Google Calendar",
            "lastSynced": "15 days ago",
            "contacts": 11,
            "status": "Active"
        ],
        [
            "name": "CSV Import",
            "lastSynced": "15 days ago",
            "contacts": 4,
            "status": "Active"
        ],
        [
            "name": "CSV Import",
            "lastSynced": "15 days ago",
            "contacts": 1056,
            "status": "Active"
        ],
        [
            "name": "vCard Import",
            "lastSynced": "15 days ago",
            "contacts": 0,
            "status": "Active"
        ],
        [
            "name": "CSV Import",
            "lastSynced": "15 days ago",
            "contacts": 612,
            "status": "Active"
        ],
        [
            "name": "Google Contacts",
            "lastSynced": "18 days ago",
            "contacts": 4,
            "status": "Active"
        ],
        [
            "name": "Outlook",
            "lastSynced": "19 days ago",
            "contacts": 2,
            "status": "Active"
        ],
        [
            "name": "iCloud",
            "lastSynced": "21 days ago",
            "contacts": 2,
            "status": "Active"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncIPhoneViewTop.isHidden = true
        syncIPhoneView.isHidden = true
        hideShowSyncIPhoneViewBtn.isSelected = false
        
        iMessageViewTop.isHidden = true
        iMessageView.isHidden = true
        iMessageViewBtn.isSelected = false
        
        if let attributed = syncIPhoneLbl.attributedText?.mutableCopy() as? NSMutableAttributedString {
            
            let fullText = attributed.string as NSString
            
            let boldText = "With Capacitor (native app):"
            let normalText = "When this app is wrapped as a native iOS app, it can access your contacts directly through the Apple Contacts framework with a single permission prompt -- no manual export needed."
            
            let boldRange = fullText.range(of: boldText)
            let normalRange = fullText.range(of: normalText)
            
            // Replace with your actual font names
            let boldFont = UIFont(name: "OpenSans-SemiBold", size: 12) ?? .systemFont(ofSize: 12, weight: .semibold)
            let normalFont = UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular)
            
            if boldRange.location != NSNotFound {
                attributed.addAttribute(.font, value: boldFont, range: boldRange)
            }
            
            if normalRange.location != NSNotFound {
                attributed.addAttribute(.font, value: normalFont, range: normalRange)
            }
            
            syncIPhoneLbl.attributedText = attributed
        }
        
        let htmlString = """
        Copy the Python script below and save it as a file (e.g.
        <code>export_imessages.py</code>), then run it in Terminal with
        <code>python3 export_imessages.py</code>
        """
        
        if let data = htmlString.data(using: .utf8) {
            
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            if let attributed = try? NSMutableAttributedString(
                data: data,
                options: options,
                documentAttributes: nil
            ) {
                
                let fullRange = NSRange(location: 0, length: attributed.length)
                
                let normalFont = UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular)
                let normalColor = UIColor(named: "#4D5256")
                
                attributed.addAttributes([
                    .font: normalFont,
                    .foregroundColor: normalColor ?? .lightGray
                ], range: fullRange)
                
                let codeFont = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
                
                let text = attributed.string as NSString
                let codeWords = ["export_imessages.py", "python3 export_imessages.py"]
                
                for word in codeWords {
                    let range = text.range(of: word)
                    if range.location != NSNotFound {
                        attributed.addAttributes([
                            .font: codeFont,
                            .backgroundColor: UIColor(named: "#DFE2E4") ?? .systemGray5
                        ], range: range)
                    }
                }
                
                runExportScriptLbl.numberOfLines = 0
                runExportScriptLbl.attributedText = attributed
            }
        }
        
        let htmlString2 = """
        The script saves a file called <code>imessage_export.csv</code> to your Desktop. Upload it here to log your text message interactions.
        """
        
        if let data = htmlString2.data(using: .utf8) {
            
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            if let attributed = try? NSMutableAttributedString(
                data: data,
                options: options,
                documentAttributes: nil
            ) {
                
                let fullRange = NSRange(location: 0, length: attributed.length)
                
                let normalFont = UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular)
                let normalColor = UIColor(named: "#4D5256")
                
                attributed.addAttributes([
                    .font: normalFont,
                    .foregroundColor: normalColor ?? .lightGray
                ], range: fullRange)
                
                let codeFont = UIFont.monospacedSystemFont(ofSize: 12, weight: .regular)
                
                let text = attributed.string as NSString
                let codeWords = ["imessage_export.csv"]
                
                for word in codeWords {
                    let range = text.range(of: word)
                    if range.location != NSNotFound {
                        attributed.addAttributes([
                            .font: codeFont,
                            .backgroundColor: UIColor(named: "#DFE2E4") ?? .systemGray5
                        ], range: range)
                    }
                }
                
                uploadCSV.numberOfLines = 0
                uploadCSV.attributedText = attributed
            }
        }
    }
    
    @IBAction func menu(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? SideMenuNavigationController
        else { return }
        destVC.settings = SharedMethods.shared.sideMenuSettings()
        SharedMethods.shared.presentVC(destVC: destVC)
    }
    
    @IBAction func darkLightMode(_ sender: UIButton) {
        
    }
    
    @IBAction func hideShowSyncIPhoneView(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideShowSyncIPhoneViewBtn.isSelected = sender.isSelected
        if sender.isSelected {
            syncIPhoneView.isHidden = false
            syncIPhoneViewTop.isHidden = false
        } else {
            syncIPhoneView.isHidden = true
            syncIPhoneViewTop.isHidden = true
        }
    }
    
    @IBAction func hideShowIMessageView(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        iMessageViewBtn.isSelected = sender.isSelected
        if sender.isSelected {
            iMessageView.isHidden = false
            iMessageViewTop.isHidden = false
        } else {
            iMessageView.isHidden = true
            iMessageViewTop.isHidden = true
        }
    }
}

extension ImportSyncVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sources.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConnectedSourceCell.identifier, for: indexPath) as! ConnectedSourceCell
        let source = sources[indexPath.row]
        let name = source["name"] as? String ?? ""
        let lastSynced = source["lastSynced"] as? String ?? ""
        let contacts = source["contacts"] as? Int ?? 0
        cell.sourceLbl.text = name
        if contacts > 0 {
            let contactText = contacts == 1 ? "contact" : "contacts"
            cell.lastSyncedLbl.text = "Last synced \(lastSynced) | \(contacts) \(contactText)"
        } else {
            cell.lastSyncedLbl.text = "Last synced \(lastSynced)"
        }
        return cell
    }
}
