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
    var addedContacts = [NewContactInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyView.isHidden = true
        tableView.isHidden = false
        
        let info1 = NewContactInfo(firstName: "Aaron", lastName: "Cohn", email: "support@graft.com", phoneNumber: "(203)524-7262", initials: "AC")
        let info2 = NewContactInfo(firstName: "David", lastName: "Hanley", email: "support@graft.com", phoneNumber: "(203)524-7262", initials: "DH")
        let info3 = NewContactInfo(firstName: "Abby", lastName: "Barlett", email: "support@graft.com", phoneNumber: "(203)524-7262", initials: "AB")
        let info4 = NewContactInfo(firstName: "Agustina", lastName: "Hobbs", email: "support@graft.com", phoneNumber: "(203)524-7262", initials: "AH")
        
        addedContacts.append(info1)
        addedContacts.append(info2)
        addedContacts.append(info3)
        addedContacts.append(info4)
        
        contactsCountLbl.text = "\(addedContacts.count) contacts"
        
        tableView.reloadData()
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
        cell.initialLbl.text = details.initials ?? ""
        let fn = details.firstName ?? ""
        let ln = details.lastName ?? ""
        let fullName = "\(fn) \(ln)".trimmingCharacters(in: .whitespaces)
        cell.nameLbl.text = fullName
        cell.emailLbl.text = details.email ?? ""
        cell.phoneLbl.text = details.phoneNumber ?? ""
        
        cell.moreBtn.tag = indexPath.row
        cell.moreBtn.addTarget(self, action: #selector(moreOptions(_ :)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SharedMethods.shared.pushToWithoutData(destVC: ContactDetailsVC.self, storyboard: .main, isAnimated: false)
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

import UIKit

class TagPopupView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tags: [[String: Any]] = []
    var selectedTag: [String: Any]?
    var didSelectTag: (([String: Any]) -> Void)?
    
    private let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: "#E6E7E9")
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 45
        tableView.layer.cornerRadius = 12
        tableView.backgroundColor = UIColor(named: "#E6E7E9")
        tableView.registerCellFromNib(cellID: TagCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.identifier, for: indexPath) as! TagCell
        let tag = tags[indexPath.row]
        cell.tagLbl.text = tag["tag"] as? String ?? ""
        let colorName = tag["color"] as? String ?? ""
        cell.tagIcon.tintColor = UIColor(named: colorName)
        if colorName.isEmpty {
            cell.tagWidth.constant = 0.0
            cell.tagTrailing.constant = 0.0
        } else {
            cell.tagWidth.constant = 16.0
            cell.tagTrailing.constant = 10.0
        }
        let selectedTagValue = selectedTag?["tag"] as? String ?? ""
        if selectedTagValue == tag["tag"] as? String ?? "" {
            cell.selectedIcon.isHidden = false
        } else {
            cell.selectedIcon.isHidden = true
        }
        
        //cell.backgroundColor = UIColor(named: "#E6E7E9")
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        let tag = tags[indexPath.row]
        selectedTag = tag
        didSelectTag?(tag)
    }
}

extension AllContactsVC: ServicesEvents {
    func createdContact(info: NewContactInfo) {
        addedContacts.insert(info, at: 0)
        contactsCountLbl.text = "\(addedContacts.count) contacts"
        tableView.reloadData()
    }
}
