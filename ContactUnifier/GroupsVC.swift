import UIKit
import SideMenu

class GroupsVC: UIViewController {
    
    @IBOutlet weak var groupCount: OpenSansLbl!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.sectionFooterHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.registerCellFromNib(cellID: GroupCell.identifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        }
    }
    
    //    var groups = [
    //        ["tag": "business", "color": "#EF4444", "subTag": "Business contacts"],
    //        ["tag": "close friends", "color": "#D946EF", "subTag": "Best Friends"],
    //        ["tag": "colleague", "color": "#8B5CF6", "subTag": "Work colleagues"],
    //        ["tag": "consulting", "color": "#F97316", "subTag": "Consulting contacts"],
    //        ["tag": "designer", "color": "#EC4899", "subTag": "Designers and creatives"],
    //        ["tag": "finance", "color": "#10B981", "subTag": "Finance contacts"],
    //        ["tag": "friend", "color": "#3B82F6", "subTag": "Personal friends"],
    //        ["tag": "investor", "color": "#A855F7", "subTag": "Investors and VCs"],
    //        ["tag": "networking", "color": "#14B8A6", "subTag": "Networking connections"],
    //        ["tag": "tech", "color": "#F59E0B", "subTag": "Tech industry"],
    //        ["tag": "vip", "color": "#0EA5E9", "subTag": "Very important people"],
    //        ["tag": "wellness", "color": "#84CC16", "subTag": "Health and wellness"]]
    
    var groups = [TagData]()
    fileprivate var tagColors = Set<ColorData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await getColors()
            await getTags()
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
    
    @IBAction func createTag(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "CreateTagVC") as? CreateTagVC
        else { return }
        destVC.servicesEvents = self
        destVC.tagColors = tagColors
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
        cell.tagLbl.text = group.name ?? ""
        cell.subTagLbl.text = group.description ?? ""
        cell.tagIcon.backgroundColor = UIColor(hex: group.color ?? "")
        if indexPath.row%2==0 {
            cell.contactCountLbl.text = "1 contact"
        } else {
            cell.contactCountLbl.text = "3 contacts"
        }
        return cell
    }
}

extension GroupsVC: ServicesEvents {
    func createdTag(info: NewAddingInfo) {
        let params: [String: Any] = [
            "name": info.tagName ?? "",
            "description": info.tagDesc ?? "",
            "color": info.tagHexaColor ?? ""
        ]
        Task {
            await createTag(params)
        }
    }
}

extension GroupsVC {
    
    fileprivate func getTags() async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .tags,
                                                             model: TagsModel.self,
                                                             method: .get,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                if let tags = details.data {
                    groups = tags
                    groupCount.text = "\(groups.count) tags to organize your contacts"
                    tableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func createTag(_ params: [String: Any]) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .tags,
                                                             model: TagModel.self,
                                                             params: params,
                                                             method: .post,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                Toast.show(message: "Contact added successfully.") {
                    if let tag = details.data {
                        self.groups.insert(tag, at: 0)
                        self.groupCount.text = "\(self.groups.count) tags to organize your contacts"
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    fileprivate func getColors() async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .colors,
                                                             model: ColorsModel.self,
                                                             method: .get,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                if let colors = details.data {
                    tagColors = Set(colors)
                }
            }
        }
    }
}
