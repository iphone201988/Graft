import UIKit
import SideMenu

var selectedCustomOptions = [String]()

class DashboardVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.sectionFooterHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.registerCellFromNib(cellID: DashboardCell.identifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var recTableView: UITableView! {
        didSet{
            recTableView.sectionFooterHeight = 0
            recTableView.estimatedSectionFooterHeight = 0
            recTableView.registerCellFromNib(cellID: UserCell.identifier)
            recTableView.showsVerticalScrollIndicator = false
            recTableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var favTableView: UITableView! {
        didSet{
            favTableView.sectionFooterHeight = 0
            favTableView.estimatedSectionFooterHeight = 0
            favTableView.registerCellFromNib(cellID: UserCell.identifier)
            favTableView.showsVerticalScrollIndicator = false
            favTableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var birthdayTableView: UITableView! {
        didSet{
            birthdayTableView.sectionFooterHeight = 0
            birthdayTableView.estimatedSectionFooterHeight = 0
            birthdayTableView.registerCellFromNib(cellID: UserCell.identifier)
            birthdayTableView.showsVerticalScrollIndicator = false
            birthdayTableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var optionCollectionView: UICollectionView! {
        didSet {
            optionCollectionView.registerCellFromNib(cellID: CustomOptionCell.identifier)
            optionCollectionView.showsVerticalScrollIndicator = false
            optionCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var customizeBtn: UIButton!
    @IBOutlet weak var customizeView: UIView!
    @IBOutlet weak var resetView: UIView!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var resetDoneView: UIView!
    @IBOutlet weak var resetDoneBottomView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var optionsBottomView: UIView!
    
    var dashboardMenus = [["title": "Total Contacts", "count": "1393", "desc": "Across all sources", "icon": "Frame-2"],
                          ["title": "Duplicate Found", "count": "710", "desc": "Need review", "icon": "Frame 2"],
                          ["title": "Lost Touch", "count": "1344", "desc": "No contact in 90+ days", "icon": "Frame-1 1"],
                          ["title": "Connected Sources", "count": "8", "desc": "Active sync sources", "icon": "Frame-2 1"]]
    
    var recents = [["inital": "KA", "name": "Kathryn Avery", "msg": "call - Opened Phone Call", "time": "11 days ago"],
                   ["inital": "NA", "name": "Nora Allen", "msg": "message - Opened SMS", "time": "14 days ago"],
                   ["inital": "NA", "name": "Nora Allen", "msg": "message - Opened SMS", "time": "14 days ago"],
                   ["inital": "NA", "name": "Nora Allen", "msg": "call - Opened Phone Call", "time": "14 days ago"],
                   ["inital": "NA", "name": "Nora Allen", "msg": "message - Opened WhatsApp", "time": "14 days ago"]]
    
    var favs = [["inital": "AB", "name": "Abby Barlett", "msg": "JP Morgan Financial Partners", "time": ""],
                ["inital": "JR", "name": "James Rodriguez", "msg": "Apex Financial Partners", "time": ""],
                ["inital": "OP", "name": "Olivia Patterson", "msg": "Bloom Wellness", "time": ""],
                ["inital": "SM", "name": "Sarah Mitchell", "msg": "Greenfield Design Co.", "time": ""],
                ["inital": "TK", "name": "Toren Kutnick", "msg": "+16072273174", "time": ""]]
    
    var birthdays = [["inital": "BU", "name": "James Patterson", "msg": "March 15", "time": "20 days"],
                     ["inital": "VV", "name": "Victoria Veneziano", "msg": "April 12", "time": "48 days"],
                     ["inital": "GM", "name": "Grace Myers", "msg": "May 11", "time": "77 days"]]
    
    var customOptions = ["Show:", "Key Metrics", "Recent Activity", "Favorites", "Upcoming Birthdays", "Potential Duplicates"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = LeftAlignedFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = .zero
        optionCollectionView.collectionViewLayout = layout
        
        resetDoneView.isHidden = true
        resetDoneBottomView.isHidden = true
        optionsView.isHidden = true
        optionsBottomView.isHidden = true
        
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "ConnectYourContactsVC") as? ConnectYourContactsVC
        else { return }
        SharedMethods.shared.presentVC(destVC: destVC, modalPresentationStyle: .overFullScreen)
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
    
    @IBAction func customizeOptions(_ sender: UIButton) {
        resetDoneView.isHidden = false
        resetDoneBottomView.isHidden = false
        optionsView.isHidden = false
        optionsBottomView.isHidden = false
        resetView.backgroundColor = .clear
    }
    
    @IBAction func resetSelections(_ sender: UIButton) {
        if selectedCustomOptions.isEmpty { return }
        resetView.backgroundColor = UIColor(named: "#F1F1F1")
        selectedCustomOptions.removeAll()
        optionCollectionView.reloadData()
        customizeView.backgroundColor = .clear
    }
    
    @IBAction func done(_ sender: UIButton) {
        resetDoneView.isHidden = true
        resetDoneBottomView.isHidden = true
        optionsView.isHidden = true
        optionsBottomView.isHidden = true
    }
}

extension DashboardVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == recTableView {
            return recents.count
        } else if tableView == favTableView {
            return favs.count
        } else if tableView == birthdayTableView {
            return birthdays.count
        } else {
            return dashboardMenus.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == recTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
            let details = recents[indexPath.row]
            let inital = details["inital"]
            let name = details["name"]
            let msg = details["msg"]
            let time = details["time"]
            
            cell.initalLbl.text = inital
            cell.nameLbl.text = name
            cell.msgLbl.text = msg
            cell.timeLbl.text = time
            cell.starIcon.isHidden = true
            cell.dayView.isHidden = true
            
            if indexPath.row == 0 {
                cell.initialView.backgroundColor = UIColor(named: "#1855AA")
            } else {
                cell.initialView.backgroundColor = UIColor(named: "#1B986E")
            }
            return cell
        } else if tableView == favTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
            let details = favs[indexPath.row]
            let inital = details["inital"]
            let name = details["name"]
            let msg = details["msg"]
            let time = details["time"]
            
            cell.initalLbl.text = inital
            cell.nameLbl.text = name
            cell.msgLbl.text = msg
            cell.timeLbl.text = time
            cell.starIcon.isHidden = false
            cell.dayView.isHidden = true
            
            if indexPath.row == 0 || indexPath.row == 4 {
                cell.initialView.backgroundColor = UIColor(named: "#1B8398")
            } else if indexPath.row == 1 || indexPath.row == 2 {
                cell.initialView.backgroundColor = UIColor(named: "#BB781B")
            } else {
                cell.initialView.backgroundColor = UIColor(named: "#1B986E")
            }
            
            return cell
        }  else if tableView == birthdayTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
            let details = birthdays[indexPath.row]
            let inital = details["inital"]
            let name = details["name"]
            let msg = details["msg"]
            let time = details["time"]
            
            cell.initalLbl.text = inital
            cell.nameLbl.text = name
            cell.msgLbl.text = msg
            cell.timeLbl.text = time
            cell.starIcon.isHidden = true
            cell.dayView.isHidden = false
            
            if indexPath.row == 0 {
                cell.initialView.backgroundColor = UIColor(named: "#1B986E")
            } else if indexPath.row == 1 {
                cell.initialView.backgroundColor = UIColor(named: "#1B8398")
            } else {
                cell.initialView.backgroundColor = UIColor(named: "#1855AA")
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DashboardCell.identifier, for: indexPath) as! DashboardCell
            let details = dashboardMenus[indexPath.row]
            cell.titleLbl1.text = details["title"]
            cell.titleLbl2.text = details["count"]
            cell.titleLbl3.text = details["desc"]
            cell.icon.image = UIImage(named: details["icon"] ?? "")
            return cell
        }
    }
}

extension DashboardVC: UICollectionViewDataSource,
                       UICollectionViewDelegate,
                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        customOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = customOptions[indexPath.item]
        let font = UIFont.systemFont(ofSize: 12, weight: .medium)
        let textWidth = (text as NSString).size(withAttributes: [.font: font]).width
        let horizontalPadding: CGFloat = 26  // 32 → 24 karo
        let iconWidth: CGFloat = 16
        let spacing: CGFloat = 13
        let totalWidth = textWidth + horizontalPadding + iconWidth + spacing
        return CGSize(width: indexPath.row == 0 ? 40 : totalWidth, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomOptionCell.identifier, for: indexPath) as! CustomOptionCell
        let option = customOptions[indexPath.item]
        cell.title.text = option
        cell.iconWidth.constant = 16
        cell.iconSpacing.constant = 13
        cell.title.font = UIFont(name: "OpenSans-Medium", size: 12.0)
        
        if selectedCustomOptions.contains(option) {
            cell.optionView.backgroundColor = UIColor(named: "#155DC1")
            cell.optionView.borderWidth = 0.0
            cell.eyeIcon.image = UIImage(named: "Frame-1 2")
            cell.title.textColor = UIColor(named: "#F9FAFB")
        } else {
            cell.optionView.backgroundColor = .clear
            cell.optionView.borderWidth = 1.0
            cell.eyeIcon.image = UIImage(named: "Frame 4")
            cell.title.textColor = UIColor(named: "#1D1F20")
        }
        
        if indexPath.row == 0 {
            cell.optionView.backgroundColor = .clear
            cell.optionView.borderWidth = 0.0
            cell.eyeIcon.image = UIImage(named: "Frame 4")
            cell.title.textColor = UIColor(named: "#1D1F20")
            cell.title.font = UIFont(name: "OpenSans-Medium", size: 14.0)
            cell.iconWidth.constant = 0
            cell.iconSpacing.constant = 0
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 { return }
        
        let option = customOptions[indexPath.item]
        if selectedCustomOptions.contains(option) {
            if let index = selectedCustomOptions.firstIndex(of: option) {
                selectedCustomOptions.remove(at: index)
            }
        } else {
            selectedCustomOptions.append(option)
        }
        
        optionCollectionView.reloadData()
        
        if selectedCustomOptions.isEmpty {
            customizeView.backgroundColor = .clear
        } else {
            customizeView.backgroundColor = UIColor(named: "#F1F1F1")
        }
        
        resetView.backgroundColor = .clear
    }
}

class LeftAlignedFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let originalAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        let attributes = originalAttributes.map { $0.copy() as! UICollectionViewLayoutAttributes }
        
        var leftMargin: CGFloat = sectionInset.left
        var maxY: CGFloat = -1.0
        
        for layoutAttribute in attributes {
            guard layoutAttribute.representedElementCategory == .cell else { continue }
            
            // ✅ New row detect — origin.y change hua matlab new row
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        
        return attributes
    }
}

class DynamicHeightCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
}
