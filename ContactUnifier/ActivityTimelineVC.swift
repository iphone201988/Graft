import UIKit
import SideMenu

class ActivityTimelineVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.sectionFooterHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.registerCellFromNib(cellID: HeaderCell.identifier)
            tableView.registerCellFromNib(cellID: TimelineCell.identifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        }
    }
    
    let activityData: [String: [[String: Any]]] = [
        
        "February 2026": [
            [
                "name": "Kathryn Avery",
                "type": "Call",
                "time": "7:44 PM",
                "title": "Opened Phone Call",
                "subtitle": "",
                "icon": "Frame 38"
            ],
            [
                "name": "Nora Allen",
                "type": "Message",
                "time": "6:38 AM",
                "title": "Opened SMS",
                "subtitle": "",
                "icon": "Frame 40"
            ],
            [
                "name": "Nora Allen",
                "type": "Message",
                "time": "6:38 AM",
                "title": "Opened SMS",
                "subtitle": "",
                "icon": "Frame 40"
            ],
            [
                "name": "Nora Allen",
                "type": "Call",
                "time": "6:38 AM",
                "title": "Opened Phone Call",
                "subtitle": "",
                "icon": "Frame 38"
            ],
            [
                "name": "Nora Allen",
                "type": "Message",
                "time": "6:38 AM",
                "title": "Opened WhatsApp",
                "subtitle": "",
                "icon": "Frame 40"
            ],
            [
                "name": "Richard Johnson",
                "type": "Email",
                "time": "12:10 AM",
                "title": "Opened Email",
                "subtitle": "",
                "icon": "Frame 41"
            ],
            [
                "name": "Sarah Mitchell",
                "type": "Email",
                "time": "11:25 PM",
                "title": "Project kickoff meeting notes",
                "subtitle": "Discussed Q2 design sprint timeline",
                "icon": "Frame 41"
            ],
            [
                "name": "Olivia Patterson",
                "type": "Email",
                "time": "11:25 PM",
                "title": "Partnership proposal draft",
                "subtitle": "",
                "icon": "Frame 41"
            ],
            [
                "name": "Olivia Patterson",
                "type": "Video",
                "time": "11:25 PM",
                "title": "Wellness program consultation",
                "subtitle": "Discussed partnership opportunity for corporate wellness",
                "icon": "Frame 42"
            ],
            [
                "name": "Sarah Mitchell",
                "type": "Call",
                "time": "11:25 PM",
                "title": "Quick catch-up",
                "subtitle": "Talked about the new branding project",
                "icon": "Frame 38"
            ]
        ],
        
        "January 2026": [
            [
                "name": "James Rodriguez",
                "type": "Meeting",
                "time": "11:25 PM",
                "title": "Quarterly review presentation",
                "subtitle": "Went over portfolio performance",
                "icon": "Frame 39"
            ],
            [
                "name": "James Rodriguez",
                "type": "Email",
                "time": "11:25 PM",
                "title": "Follow-up on investment strategy",
                "subtitle": "",
                "icon": "Frame 41"
            ],
            [
                "name": "Dup Alpha",
                "type": "Message",
                "time": "4:00 PM",
                "title": "iMessage conversation",
                "subtitle": "2 messages exchanged",
                "icon": "Frame 40"
            ]
        ],
        
        "December 2025": [
            [
                "name": "Emily Chen",
                "type": "Message",
                "time": "11:25 PM",
                "title": "Birthday wishes",
                "subtitle": "Sent birthday greetings and caught up",
                "icon": ""
            ]
        ],
        
        "October 2025": [
            [
                "name": "Marcus Thompson",
                "type": "Email",
                "time": "11:25 PM",
                "title": "Tech meetup invitation",
                "subtitle": "Invited to speak at Chicago JS meetup",
                "icon": "Frame 41"
            ]
        ]
    ]
    
    var sections: [String] {
        return Array(activityData.keys)
    }
    
    var dates = ["February 2026", "January 2026", "December 2025", "October 2025"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}

// MARK: Delegates and DataSources
extension ActivityTimelineVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = dates[section]
        return activityData[sectionKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as? HeaderCell
        else { return nil }
        let keyName = dates[section]
        cell.headerLbl.text = keyName
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimelineCell.identifier, for: indexPath) as! TimelineCell
        let sectionKey = dates[indexPath.section]
        let item = activityData[sectionKey]?[indexPath.row]
        cell.name.text = item?["name"] as? String
        cell.type.text = item?["type"] as? String
        cell.time.text = item?["time"] as? String
        cell.source.text = item?["title"] as? String
        cell.remark.text = item?["subtitle"] as? String
        cell.remark.isHidden = (item?["subtitle"] as? String) == ""
        cell.icon.image = UIImage(named: item?["icon"] as? String ?? "")
        return cell
    }
}
