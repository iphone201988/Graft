import UIKit
import SideMenu

class LostTouchVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.sectionFooterHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.registerCellFromNib(cellID: LostTouchCell.identifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellFromNib(cellID: DayCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyLbl: OpenSansLbl!
    
    let contactsData: [[String: Any]] = [
        
        [
            "initials": "RN",
            "name": "Rachel Nguyen",
            "company": "Cascade Architecture",
            "email": "rachel.nguyen@gmail.com",
            "lastContact": "about 1 year ago",
            "status": "1+ year",
            "neverContacted": false,
            "color": "#10B981"
        ],
        [
            "initials": "DK",
            "name": "David Kim",
            "company": "NorthStar Ventures",
            "email": "david.kim@proton.me",
            "lastContact": "7 months ago",
            "status": "90+ days",
            "neverContacted": false,
            "color": "#0EA5E9"
        ],
        [
            "initials": "MT",
            "name": "Marcus Thompson",
            "company": "TechBridge Solutions",
            "email": "marcus.t@gmail.com",
            "lastContact": "5 months ago",
            "status": "90+ days",
            "neverContacted": false,
            "color": "#3B82F6"
        ],
        [
            "initials": "CA",
            "name": "Chantel ALSW",
            "company": "",
            "email": "",
            "lastContact": "Never contacted",
            "status": "2+ years",
            "neverContacted": true,
            "color": "#8B5CF6"
        ],
        [
            "initials": "A",
            "name": "Amber",
            "company": "Rising Starr",
            "email": "",
            "lastContact": "Never contacted",
            "status": "2+ years",
            "neverContacted": true,
            "color": "#84CC16"
        ],
        [
            "initials": "AA",
            "name": "Alyvia Anderson",
            "company": "",
            "email": "",
            "lastContact": "Never contacted",
            "status": "2+ years",
            "neverContacted": true,
            "color": "#6366F1"
        ],
        [
            "initials": "EA",
            "name": "Emily Anderson",
            "company": "",
            "email": "",
            "lastContact": "Never contacted",
            "status": "2+ years",
            "neverContacted": true,
            "color": "#6366F1"
        ],
        [
            "initials": "A",
            "name": "Andrew",
            "company": "",
            "email": "",
            "lastContact": "Never contacted",
            "status": "2+ years",
            "neverContacted": true,
            "color": "#F97316"
        ],
        [
            "initials": "JA",
            "name": "Jhappa - Simran",
            "company": "",
            "email": "",
            "lastContact": "Never contacted",
            "status": "2+ years",
            "neverContacted": true,
            "color": "#F59E0B"
        ],
        [
            "initials": "SA",
            "name": "Sheana Arevalo",
            "company": "",
            "email": "",
            "lastContact": "Never contacted",
            "status": "1+ years",
            "neverContacted": true,
            "color": "#F97316"
        ],
        [
            "initials": "GA",
            "name": "Greg Augustnyak",
            "company": "",
            "email": "",
            "lastContact": "Never contacted",
            "status": "6 months",
            "neverContacted": true,
            "color": "#64748B"
        ]
    ]
    
    let days = [["title": "30 Days", "msg": "30+ days"],
                ["title": "60 Days", "msg": "60+ days"],
                ["title": "90 Days", "msg": "90+ days"],
                ["title": "1 Year", "msg": "365+ days"],
                ["title": "2 Years", "msg": "730+ days"]]
    
    var selectedDay = "90 Days"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden = true
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
extension LostTouchVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LostTouchCell.identifier, for: indexPath) as! LostTouchCell
        let item = contactsData[indexPath.row]
        cell.initialLbl.text = item["initials"] as? String
        cell.name.text = item["name"] as? String
        cell.about.text = item["lastContact"] as? String
        cell.days.text = item["status"] as? String
        
        let color = item["color"] as? String ?? ""
        cell.initialView.backgroundColor = UIColor(named: color)
        
        let email = item["email"] as? String ?? ""
        let company = item["company"] as? String ?? ""
        
        if !company.isEmpty {
            cell.companyView.isHidden = false
            cell.companyTop.isHidden = false
            cell.company.text = company
        } else {
            cell.companyView.isHidden = true
            cell.companyTop.isHidden = true
        }
        
        if !email.isEmpty {
            cell.emailView.isHidden = false
            cell.emailTop.isHidden = false
            cell.email.text = email
        } else {
            cell.emailView.isHidden = true
            cell.emailTop.isHidden = true
        }
        
        let lastContact = item["lastContact"] as? String ?? ""
        if lastContact.contains("about") {
            cell.about.textColor = UIColor(named: "#BB781B")
        } else if lastContact.contains("ago") {
            cell.about.textColor = UIColor(named: "#4D5256")
        } else {
            cell.about.textColor = UIColor(named: "#C91D1D")
        }
        
        if email.isEmpty && company.isEmpty {
            cell.contentViewTop.constant = 25
        } else {
            cell.contentViewTop.constant = 14
        }
        
        return cell
    }
}

extension LostTouchVC: UICollectionViewDataSource,
                       UICollectionViewDelegate,
                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        days.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let details = days[indexPath.row]
        let title = details["title"] ?? ""
        let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        let textWidth = (title as NSString).size(withAttributes: [.font: font]).width
        let horizontalPadding: CGFloat = 12
        let totalWidth = textWidth + horizontalPadding + 15
        return CGSize(width: totalWidth, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.identifier, for: indexPath) as! DayCell
        let details = days[indexPath.row]
        let title = details["title"] ?? ""
        cell.dayLbl.text = title
        if selectedDay == title {
            cell.dayView.backgroundColor = UIColor(named: "#FAFAFA")
        } else {
            cell.dayView.backgroundColor = .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let details = days[indexPath.row]
        let title = details["title"] ?? ""
        let msg = details["msg"] ?? ""
        selectedDay = title
        if indexPath.row != 2 {
            emptyView.isHidden = false
            tableView.isHidden = true
        } else {
            emptyView.isHidden = true
            tableView.isHidden = false
        }
        self.collectionView.reloadData()
        emptyLbl.text = "No contacts have gone without interaction for \(msg)"
    }
}
