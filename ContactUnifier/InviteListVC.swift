import UIKit
import SideMenu

class InviteListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.sectionFooterHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.registerCellFromNib(cellID: InviteCell.identifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var emptyView: UIView!
    
    var listNames = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden = false
        tableView.isHidden = true
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
    
    @IBAction func createNewList(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "CreateInviteListVC") as? CreateInviteListVC
        else { return }
        destVC.servicesEvents = self
        SharedMethods.shared.presentVC(destVC: destVC, modalPresentationStyle: .overFullScreen)
    }
}

// MARK: Delegates and DataSources
extension InviteListVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InviteCell.identifier, for: indexPath) as! InviteCell
        let details = listNames[indexPath.row]
        cell.name.text = details["name"] as? String ?? ""
        cell.desc.text = details["desc"] as? String ?? ""
        return cell
    }
}

extension InviteListVC: ServicesEvents {
    func createdList(listName: String, listDesc: String) {
        emptyView.isHidden = true
        tableView.isHidden = false
        let info = ["name": listName, "desc": listDesc]
        listNames.append(info)
        tableView.reloadData()
    }
}
