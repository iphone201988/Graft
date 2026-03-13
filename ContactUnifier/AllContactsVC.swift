import UIKit
import SideMenu

class AllContactsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.sectionFooterHeight = 0
            tableView.estimatedSectionFooterHeight = 0
            tableView.registerCellFromNib(cellID: ContactCell.identifier)
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var searchContactTF: OpenSansTF!
    @IBOutlet weak var allSourcesTF: OpenSansTF!
    @IBOutlet weak var allTagsTF: OpenSansTF!
    @IBOutlet weak var allSourcesBtn: UIButton!
    @IBOutlet weak var allTagsBtn: UIButton!
    @IBOutlet weak var tagIcon: UIImageView!
    @IBOutlet weak var tagLbl: OpenSansLbl!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var contactsCountLbl: OpenSansLbl!
    
    var sources = [["tag": "All Sources", "color": ""],
                   ["tag": "Vcard", "color": ""],
                   ["tag": "Csv", "color": ""],
                   ["tag": "Manual", "color": ""],
                   ["tag": "Icloud", "color": ""],
                   ["tag": "Outlook", "color": ""],
                   ["tag": "Google", "color": ""]]
    
    var tags = [["tag": "All Tags", "color": ""],
                ["tag": "business", "color": "#EF4444"],
                ["tag": "close friends", "color": "#D946EF"],
                ["tag": "colleague", "color": "#8B5CF6"],
                ["tag": "consulting", "color": "#F97316"],
                ["tag": "designer", "color": "#EC4899"],
                ["tag": "finance", "color": "#10B981"],
                ["tag": "friend", "color": "#3B82F6"],
                ["tag": "investor", "color": "#A855F7"],
                ["tag": "networking", "color": "#14B8A6"],
                ["tag": "tech", "color": "#F59E0B"],
                ["tag": "vip", "color": "#0EA5E9"],
                ["tag": "wellness", "color": "#84CC16"]]
    
    var selectedSource: [String: Any] = ["tag": "All Sources", "color": ""]
    var selectedTag: [String: Any] = ["tag": "All Tags", "color": ""]
    var sourcePopupView: TagPopupView?
    var tagPopupView: TagPopupView?
    var viewAllFavorites: Bool = false
    var addedContacts = [ContactData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyView.isHidden = true
        tableView.isHidden = false
        contactsCountLbl.text = "\(addedContacts.count) contacts"
        tableView.reloadData()
        Task {
            await getContacts()
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updatedContact(_ :)),
                                               name: .updatedContact,
                                               object: nil)
    }
    
    @objc fileprivate func updatedContact(_ notify: Notification) {
        if let obj = notify.object as? ContactData,
           let id = obj.id {
            if let index = addedContacts.firstIndex(where: { $0.id == id }) {
                addedContacts[index] = obj
                tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
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
    
    @IBAction func addContact(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "AddNewContactVC") as? AddNewContactVC
        else { return }
        destVC.servicesEvents = self
        SharedMethods.shared.presentVC(destVC: destVC)
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
            allSourcesTF.text = tagName
            tableView.reloadData()
            
            //            if tagName == "All Sources" {
            //                emptyView.isHidden = true
            //                tableView.isHidden = false
            //            } else {
            //                emptyView.isHidden = false
            //                tableView.isHidden = true
            //            }
        }
        
        view.addSubview(popup)
        popup.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popup.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: 8),
            popup.leadingAnchor.constraint(equalTo: sender.leadingAnchor),
            popup.widthAnchor.constraint(equalToConstant: 180),
            popup.heightAnchor.constraint(equalToConstant: 330)
        ])
        
        sourcePopupView = popup
    }
    
    @IBAction func chooseTag(_ sender: UIButton) {
        if tagPopupView != nil {
            tagPopupView?.removeFromSuperview()
            tagPopupView = nil
            return
        }
        
        let popup = TagPopupView()
        popup.tags = tags
        popup.selectedTag = selectedTag
        popup.backgroundColor = .orange
        
        popup.didSelectTag = { [weak self] tag in
            guard let self = self else { return }
            self.selectedTag = tag
            self.tagPopupView?.removeFromSuperview()
            self.tagPopupView = nil
            let tagName = selectedTag["tag"] as? String ?? ""
            let tagColor = selectedTag["color"] as? String ?? ""
            tagLbl.text = tagName
            if tagColor.isEmpty {
                tagIcon.isHidden = true
            } else {
                tagIcon.isHidden = false
                tagIcon.backgroundColor = UIColor(named: tagColor)
            }
            
            if tagName == "All Tags" {
                emptyView.isHidden = true
                tableView.isHidden = false
            } else {
                emptyView.isHidden = false
                tableView.isHidden = true
            }
        }
        
        view.addSubview(popup)
        popup.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popup.topAnchor.constraint(equalTo: sender.bottomAnchor, constant: 8),
            popup.leadingAnchor.constraint(equalTo: sender.leadingAnchor),
            popup.widthAnchor.constraint(equalToConstant: 180),
            popup.heightAnchor.constraint(equalToConstant: 400)
        ])
        
        tagPopupView = popup
    }
    
    func makeMenu(from items: [String],
                  selected: String,
                  selectionHandler: @escaping (String) -> Void) -> UIMenu {
        
        let actions = items.map { item in
            UIAction(
                title: item,
                state: item == selected ? .on : .off
            ) { _ in
                selectionHandler(item)
            }
        }
        
        return UIMenu(title: "", options: .singleSelection, children: actions)
    }
}

extension AllContactsVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addedContacts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.identifier, for: indexPath) as! ContactCell
        let source = selectedSource["tag"] as? String ?? "Vcard"
        if source == "All Sources" || source == "Manual" {
            cell.sourceView.isHidden = true
        } else {
            cell.sourceView.isHidden = false
            let lowercase = source.lowercased()
            cell.sourceLbl.text = lowercase
        }
        cell.companyView.isHidden = true
        cell.companyTopView.isHidden = true
        if source == "Google" || source == "Outlook" {
            cell.companyView.isHidden = false
            cell.companyTopView.isHidden = false
        }
        
        let details = addedContacts[indexPath.row]
        let initials = SharedMethods.shared.getInitials(from: details.full_name ?? "")
        cell.initialLbl.text = initials
        cell.nameLbl.text = details.full_name ?? ""
        cell.emailLbl.text = details.primary_email ?? ""
        cell.phoneLbl.text = details.primary_phone ?? ""
        
        cell.moreBtn.tag = indexPath.row
        cell.moreBtn.addTarget(self, action: #selector(moreOptions(_ :)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = addedContacts[indexPath.row]
        if let id = details.id {
            let sb = AppStoryboards.main.storyboardInstance
            let destVC = sb.instantiateViewController(withIdentifier: "ContactDetailsVC") as! ContactDetailsVC
            destVC.contactID = "\(id)"
            destVC.isShowInfo = true
            destVC.servicesEvents = self
            SharedMethods.shared.pushTo(destVC: destVC, isAnimated: false)
        }
    }
    
    @objc fileprivate func moreOptions(_ sender: UIButton) {
        let edit = UIAction(
            title: "Archive",
            image: UIImage(systemName: "archivebox")
        ) { _ in }
        
        let delete = UIAction(
            title: "Delete",
            image: UIImage(systemName: "trash"),
            attributes: .destructive
        ) { _ in }
        
        sender.menu = UIMenu(children: [edit, delete])
        sender.showsMenuAsPrimaryAction = true
    }
}

extension AllContactsVC: ServicesEvents {
    func createdContact(info: NewAddingInfo) {
        let params: [String: Any] = [
            "first_name": info.firstName ?? "",
            "last_name": info.lastName ?? "",
            "company": info.company ?? "",
            "job_title": info.jobTitle ?? "",
            "phone": info.phoneNumber ?? "",
            "email": info.email ?? "",
            "birthday": info.birthday ?? "",
            "address": [
                "street": info.street ?? "",
                "city": info.city ?? "",
                "state": info.state ?? "",
                "zip_code": info.zip ?? "",
                "country": info.country ?? ""
            ],
            "social_url": info.socialURL ?? "",
            "note": info.note ?? ""
        ]
        
        Task {
            await createContact(params)
        }
    }
    
    func deleteContact(id: String) {
        Task {
            await deleteContact(id: id)
        }
    }
}

extension AllContactsVC {
    
    fileprivate func getContacts() async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .contacts,
                                                             model: ContactsModel.self,
                                                             method: .get,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                if let contacts = details.data?.data {
                    addedContacts = contacts
                    contactsCountLbl.text = "\(addedContacts.count) contacts"
                    tableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func createContact(_ params: [String: Any]) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .contacts,
                                                             model: ContactModel.self,
                                                             params: params,
                                                             method: .post,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                Toast.show(message: "Contact added successfully.") {
                    if let contacts = details.data {
                        self.addedContacts.insert(contacts, at: 0)
                        self.contactsCountLbl.text = "\(self.addedContacts.count) contacts"
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    fileprivate func deleteContact(id: String) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .contacts,
                                                             tail: id,
                                                             model: ContactsModel.self,
                                                             method: .delete,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success:
                if let index = addedContacts.firstIndex(where: { "\($0.id ?? 0)" == id }) {
                    addedContacts.remove(at: index)
                    contactsCountLbl.text = "\(addedContacts.count) contacts"
                    tableView.reloadData()
                }
            }
        }
    }
}
