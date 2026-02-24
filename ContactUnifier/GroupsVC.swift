import UIKit
import SideMenu

class GroupsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.sectionFooterHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.registerCellFromNib(cellID: GroupCell.identifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        }
    }
    
    var groups = [
        ["tag": "business", "color": "business", "subTag": "Business contacts"],
        ["tag": "close friends", "color": "closefriends", "subTag": "Best Friends"],
        ["tag": "colleague", "color": "colleague", "subTag": "Work colleagues"],
        ["tag": "consulting", "color": "consulting", "subTag": "Consulting contacts"],
        ["tag": "designer", "color": "designer", "subTag": "Designers and creatives"],
        ["tag": "finance", "color": "finance", "subTag": "Finance contacts"],
        ["tag": "friend", "color": "friend", "subTag": "Personal friends"],
        ["tag": "investor", "color": "investor", "subTag": "Investors and VCs"],
        ["tag": "networking", "color": "networking", "subTag": "Networking connections"],
        ["tag": "tech", "color": "tech", "subTag": "Tech industry"],
        ["tag": "vip", "color": "vip", "subTag": "Very important people"],
        ["tag": "wellness", "color": "wellness", "subTag": "Health and wellness"]]
    
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

extension GroupsVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell
        let group = groups[indexPath.row]
        let tag = group["tag"]
        let subTag = group["subTag"]
        let colorName = group["color"]
        cell.tagLbl.text = tag
        cell.subTagLbl.text = subTag
        cell.tagIcon.backgroundColor = UIColor(named: colorName ?? "")
        if indexPath.row%2==0 {
            cell.contactCountLbl.text = "1 contact"
        } else {
            cell.contactCountLbl.text = "3 contacts"
        }
        return cell
    }
}
