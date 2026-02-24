import UIKit

var selectedOptions = ""

class SideMenuOptionsVC: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.sectionFooterHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.registerCellFromNib(cellID: HeaderCell.identifier)
            tableView.registerCellFromNib(cellID: OptionCell.identifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        }
    }
    
    // MARK: Variables
    var menus = [["section": "Overview", "options": [["title": "Dashboard", "icon": "Frame-1"],
                                                     ["title": "All Contacts", "icon": "Frame-2"],
                                                     ["title": "Groups", "icon": "Frame-3"],
                                                     ["title": "Import & Sync", "icon": "Frame-4"]] ],
                 ["section": "Manage", "options": [["title": "Clean Up", "icon": "Frame-5"],
                                                   ["title": "Activity Timeline", "icon": "Frame-6"],
                                                   ["title": "Lost Touch", "icon": "Frame-7"],
                                                   ["title": "Invite Lists", "icon": "Frame-8"]] ]
    ]
    
    // MARK: Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: IB Actions
    
    // MARK: Shared Methods
}

// MARK: Delegates and DataSources

extension SideMenuOptionsVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        menus.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = menus[section]
        let options = section["options"] as? NSArray ?? []
        return options.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        32
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier) as? HeaderCell
        else { return nil }
        let section = menus[section]
        let title = section["section"] as? String ?? ""
        cell.headerLbl.text = title
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.identifier, for: indexPath) as! OptionCell
        let section = menus[indexPath.section]
        let options = section["options"] as? NSArray ?? []
        let details = options[indexPath.row] as? NSDictionary ?? [:]
        let title = details["title"] as? String ?? ""
        cell.titleLbl.text = title
        cell.selectedStatusIcon.image = UIImage(named: details["icon"] as? String ?? "")
        cell.cleanUpCountView.isHidden = true
        cell.lostTouchCountView.isHidden = true
        
        if title == "Clean Up" {
            cell.cleanUpCountView.isHidden = false
        }
        
        if title == "Lost Touch" {
            cell.lostTouchCountView.isHidden = false
        }
        
        if title == selectedOptions {
            cell.optionView.backgroundColor = UIColor(named: "#D9DCDE")
        } else {
            cell.optionView.backgroundColor = .clear
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = menus[indexPath.section]
        let options = section["options"] as? NSArray ?? []
        let details = options[indexPath.row] as? NSDictionary ?? [:]
        selectedOptions = details["title"] as? String ?? ""
        
        if indexPath.row == 0 {
            dismiss(animated: false) {
                SharedMethods.shared.pushToWithoutData(destVC: DashboardVC.self, storyboard: .main, isAnimated: false)
            }
        } else if indexPath.row == 1 {
            dismiss(animated: false) {
                SharedMethods.shared.pushToWithoutData(destVC: AllContactsVC.self, storyboard: .main, isAnimated: false)
            }
        } else if indexPath.row == 2 {
            dismiss(animated: false) {
                SharedMethods.shared.pushToWithoutData(destVC: GroupsVC.self, storyboard: .main, isAnimated: false)
            }
        }
    }
}
