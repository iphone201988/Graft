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
        ["tag": "business", "color": "#EF4444", "subTag": "Business contacts"],
        ["tag": "close friends", "color": "#D946EF", "subTag": "Best Friends"],
        ["tag": "colleague", "color": "#8B5CF6", "subTag": "Work colleagues"],
        ["tag": "consulting", "color": "#F97316", "subTag": "Consulting contacts"],
        ["tag": "designer", "color": "#EC4899", "subTag": "Designers and creatives"],
        ["tag": "finance", "color": "#10B981", "subTag": "Finance contacts"],
        ["tag": "friend", "color": "#3B82F6", "subTag": "Personal friends"],
        ["tag": "investor", "color": "#A855F7", "subTag": "Investors and VCs"],
        ["tag": "networking", "color": "#14B8A6", "subTag": "Networking connections"],
        ["tag": "tech", "color": "#F59E0B", "subTag": "Tech industry"],
        ["tag": "vip", "color": "#0EA5E9", "subTag": "Very important people"],
        ["tag": "wellness", "color": "#84CC16", "subTag": "Health and wellness"]]
    
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
    
    @IBAction func createTag(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "CreateTagVC") as? CreateTagVC
        else { return }
        SharedMethods.shared.presentVC(destVC: destVC)
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
