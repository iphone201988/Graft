import UIKit
import SideMenu

class ContactDetailsVC: UIViewController {
    
    @IBOutlet weak var initialLbl: OpenSansLbl!
    @IBOutlet weak var name: OpenSansLbl!
    @IBOutlet weak var titleLbl: OpenSansLbl!
    @IBOutlet weak var company: OpenSansLbl!
    @IBOutlet weak var email: OpenSansLbl!
    @IBOutlet weak var phoneLbl: OpenSansLbl!
    @IBOutlet weak var addressLbl: OpenSansLbl!
    @IBOutlet weak var sourceLbl: OpenSansLbl!
    
    @IBOutlet weak var tbl: UITableView! {
        didSet {
            tbl.registerCellFromNib(cellID: InteractionHistoryCell.identifier)
        }
    }
    
    @IBOutlet weak var tagsCollectionView: UICollectionView! {
        didSet {
            tagsCollectionView.registerCellFromNib(cellID: AddedTagCell.identifier)
            tagsCollectionView.showsVerticalScrollIndicator = false
            tagsCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var nameLbl: OpenSansLbl!
    @IBOutlet weak var activityLbl: OpenSansLbl!
    @IBOutlet weak var interactionsCountLbl: OpenSansLbl!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyMsg: OpenSansLbl!
    @IBOutlet weak var contactInfoView: UIStackView!
    @IBOutlet weak var quickActionsTopView: UIView!
    @IBOutlet weak var quickActionsView: UIView!
    
    // No interactions recorded
    // 0 interactions
    
    var interactionLogs = [NewAddingInfo]()
    var tags = ["tech", "networking", "executive", "investor"]
    var isShowInfo: Bool = false
    var contactDetails: ContactData?
    var contactID = ""
    var servicesEvents: ServicesEvents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        emptyView.isHidden = false
        tbl.isHidden = true
        
        if isShowInfo {
            quickActionsTopView.isHidden = false
            quickActionsView.isHidden = false
            
            emptyMsg.isHidden = true
            contactInfoView.isHidden = false
        } else {
            quickActionsTopView.isHidden = true
            quickActionsView.isHidden = true
            
            emptyMsg.isHidden = false
            contactInfoView.isHidden = true
        }
        
        Task {
            await getContact()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", object is UITableView {
            UIView.performWithoutAnimation {
                if interactionLogs.isEmpty {
                    self.tblHeight.constant = 102
                } else {
                    self.tblHeight.constant = self.tbl.contentSize.height
                }
                view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func markFav(_ sender: UIButton) {
        
    }
    
    @IBAction func editContact(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "AddNewContactVC") as? AddNewContactVC
        else { return }
        destVC.servicesEvents = self
        destVC.interfaceTitle = "Edit Contact"
        destVC.contactDetails = contactDetails
        SharedMethods.shared.presentVC(destVC: destVC)
    }
    
    @IBAction func deleteContact(_ sender: UIButton) {
        PopupUtil.popupAlert(title: "Graft",
                             message: "Are you sure you want to delete this contact?",
                             actionTitles: ["Yes", "No"],
                             actions: [{ _, _ in
            self.servicesEvents?.deleteContact(id: self.contactID)
            self.navigationController?.popViewController(animated: true)
        }])
    }
    
    @IBAction func createLogInteraction(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "CreateLogInteractionVC") as? CreateLogInteractionVC
        else { return }
        destVC.servicesEvents = self
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
}

// MARK: Delegates and DataSources
extension ContactDetailsVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactionLogs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InteractionHistoryCell.identifier, for: indexPath) as! InteractionHistoryCell
        let item = interactionLogs[indexPath.row]
        cell.typeLbl.text = item.interactionType ?? ""
        cell.icon.image = UIImage(named: item.interactionIcon ?? "")
        cell.createdAtLbl.text = item.interactionCreatedAt ?? ""
        return cell
    }
}

extension ContactDetailsVC: ServicesEvents {
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
            await editContact(params, id: info.existingContactID ?? "")
        }
    }
    
    func createdLogInteraction(info: NewAddingInfo) {
        activityLbl.text = "Last contacted less than a minute ago"
        interactionLogs.append(info)
        interactionsCountLbl.text = "\(interactionLogs.count) interactions"
        tbl.reloadData()
        emptyView.isHidden = true
        tbl.isHidden = false
    }
}

extension ContactDetailsVC: UICollectionViewDataSource,
                            UICollectionViewDelegate,
                            UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lbl = UILabel(frame: .zero)
        lbl.font = UIFont(name: "OpenSans-SemiBold", size: 12.0) // Helvetica Neue 12.0
        lbl.text = tags[indexPath.row]
        lbl.sizeToFit()
        return CGSize(width: lbl.frame.width + 25, height: 21)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddedTagCell.identifier, for: indexPath) as! AddedTagCell
        let tag = tags[indexPath.row]
        cell.tagLbl.text = tag
        return cell
    }
}

extension ContactDetailsVC {
    
    fileprivate func getContact() async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .contacts,
                                                             tail: contactID,
                                                             model: ContactModel.self,
                                                             method: .get,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                if let contact = details.data {
                    self.contactDetails = contact
                    self.populateUserInfo()
                }
            }
        }
    }
    
    fileprivate func populateUserInfo() {
        sourceLbl.text = contactDetails?.source ?? ""
        initialLbl.text = SharedMethods.shared.getInitials(from: contactDetails?.full_name ?? "")
        name.text = contactDetails?.full_name ?? ""
        titleLbl.text = contactDetails?.job_title ?? ""
        company.text = contactDetails?.company ?? ""
        email.text = contactDetails?.primary_email ?? ""
        phoneLbl.text = contactDetails?.primary_phone ?? ""
        if let address = contactDetails?.addresses?.first {
            addressLbl.text = "\(address.street ?? ""), \(address.city ?? ""), \(address.state ?? "") \(address.zip_code ?? ""), \(address.country ?? "")"
        }
    }
    
    fileprivate func editContact(_ params: [String: Any], id: String) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .contacts,
                                                             tail: id,
                                                             model: ContactModel.self,
                                                             params: params,
                                                             method: .put,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                Toast.show(message: "Contact updated successfully!") {
                    if let contact = details.data {
                        self.contactDetails = contact
                        self.populateUserInfo()
                        NotificationCenter.default.post(name: .updatedContact, object: contact)
                    }
                }
            }
        }
    }
}
