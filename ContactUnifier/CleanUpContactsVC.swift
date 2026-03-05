import UIKit
import SideMenu

class CleanUpContactsVC: UIViewController {
    
    @IBOutlet weak var duplicateContactsTbl: UITableView! {
        didSet {
            duplicateContactsTbl.showsVerticalScrollIndicator = false
            duplicateContactsTbl.showsHorizontalScrollIndicator = false
            duplicateContactsTbl.registerCellFromNib(cellID: DuplicateContactCell.identifier)
            width = duplicateContactsTbl.frame.width - 50
        }
    }
    
    @IBOutlet weak var incompleteNamesTbl: UITableView! {
        didSet {
            incompleteNamesTbl.showsVerticalScrollIndicator = false
            incompleteNamesTbl.showsHorizontalScrollIndicator = false
            incompleteNamesTbl.registerCellFromNib(cellID: IncompleteNameCell.identifier)
        }
    }
    
    @IBOutlet weak var missingPhoneTbl: UITableView! {
        didSet {
            missingPhoneTbl.showsVerticalScrollIndicator = false
            missingPhoneTbl.showsHorizontalScrollIndicator = false
            missingPhoneTbl.registerCellFromNib(cellID: IncompleteNameCell.identifier)
        }
    }
    
    @IBOutlet weak var missingEmailsTbl: UITableView! {
        didSet {
            missingEmailsTbl.showsVerticalScrollIndicator = false
            missingEmailsTbl.showsHorizontalScrollIndicator = false
            missingEmailsTbl.registerCellFromNib(cellID: IncompleteNameCell.identifier)
        }
    }
    
    @IBOutlet weak var addressOnlyContactsTbl: UITableView! {
        didSet {
            addressOnlyContactsTbl.showsVerticalScrollIndicator = false
            addressOnlyContactsTbl.showsHorizontalScrollIndicator = false
            addressOnlyContactsTbl.registerCellFromNib(cellID: IncompleteNameCell.identifier)
        }
    }
    
    @IBOutlet weak var duplicateContactsEmptyView: UIView!
    @IBOutlet weak var hideShowDuplicateContactsBtn: UIButton!
    
    @IBOutlet weak var exactNamesEmptyView: UIView!
    @IBOutlet weak var hideShowExactNamesBtn: UIButton!
    
    @IBOutlet weak var emailOnlyContactsEmptyView: UIView!
    @IBOutlet weak var hideShowEmailOnlyContactsBtn: UIButton!
    
    @IBOutlet weak var incompleteNamesListView: UIView!
    @IBOutlet weak var incompleteNamesEmptyView: UIView!
    @IBOutlet weak var hideShowIncompleteNamesBtn: UIButton!
    
    @IBOutlet weak var missingPhoneListView: UIView!
    @IBOutlet weak var missingPhoneEmptyView: UIView!
    @IBOutlet weak var hideShowMissingPhoneBtn: UIButton!
    
    @IBOutlet weak var missingEmailsListView: UIView!
    @IBOutlet weak var missingEmailsEmptyView: UIView!
    @IBOutlet weak var hideShowMissingEmailsBtn: UIButton!
    
    @IBOutlet weak var addressOnlyContactsListView: UIView!
    @IBOutlet weak var addressOnlyContactsEmptyView: UIView!
    @IBOutlet weak var hideShowAddressOnlyContactsBtn: UIButton!
    @IBOutlet weak var archiveView: UIView!
    @IBOutlet weak var selectAllBtn: UIButton!
    @IBOutlet weak var selectAllIcon: UIImageView!
    
    @IBOutlet weak var exactNamesMatchesLbl: OpenSansLbl!
    @IBOutlet weak var emailOnlyContactsLbl: OpenSansLbl!
    @IBOutlet weak var incompleteNamesLbl: OpenSansLbl!
    @IBOutlet weak var missingPhoneNumberLbl: OpenSansLbl!
    @IBOutlet weak var missingEmailAddressLbl: OpenSansLbl!
    @IBOutlet weak var addressOnlyContactsLbl: OpenSansLbl!
    @IBOutlet weak var duplicateContactsTblHeight: NSLayoutConstraint!
    
    var duplicateContactsArray = [ContactInfo]()
    
    var incompleteNamesArray = ["Alicia"]
    
    var names = [["Nadia", "Nadina"],
                 ["Melissa Schwartz", "Tessa Schwartz"],
                 ["Maddie", "Maddy Jimerson"]]
    
    var selectedAddressOnlyContacts = [String]()
    
    var isActiveDuplicateContacts: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideShowDuplicateContactsBtn.isSelected = false
        duplicateContactsEmptyView.isHidden = true
        duplicateContactsTbl.isHidden = true

        hideShowExactNamesBtn.isSelected = false
        exactNamesEmptyView.isHidden = true
        exactNamesMatchesLbl.isHidden = true
        
        hideShowMissingEmailsBtn.isSelected = false
        emailOnlyContactsEmptyView.isHidden = true
        emailOnlyContactsLbl.isHidden = true

        hideShowIncompleteNamesBtn.isSelected = false
        incompleteNamesEmptyView.isHidden = true
        incompleteNamesListView.isHidden = true
        
        hideShowMissingPhoneBtn.isSelected = false
        missingPhoneEmptyView.isHidden = true
        missingPhoneListView.isHidden = true
        
        hideShowMissingEmailsBtn.isSelected = false
        missingEmailsEmptyView.isHidden = true
        missingEmailsListView.isHidden = true
        
        hideShowAddressOnlyContactsBtn.isSelected = false
        addressOnlyContactsEmptyView.isHidden = true
        addressOnlyContactsListView.isHidden = true
        archiveView.isHidden = true
        
        hideLbls()
        
        for _ in names {
            let info1 = MergeContacts(name: "Nadia",
                                      source: "vcard",
                                      phone: "+1 (317)610-6442",
                                      email: "nadia@gmail.com",
                                      company: "Kohls/Macys")
            
            let info2 = MergeContacts(name: "Nadia",
                                      source: "vcard",
                                      phone: "+1 (317)610-6442",
                                      email: "nadia@gmail.com",
                                      company: "Kohls/Macys")
            
            let contactInfo = ContactInfo(total: 2, info: [info1, info2], event: .normal)
            duplicateContactsArray.append(contactInfo)
        }
        
        duplicateContactsTbl.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        if isActiveDuplicateContacts {
            hideShowDuplicateContactsBtn.isSelected = true
            duplicateContactsEmptyView.isHidden = true
            duplicateContactsTbl.isHidden = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize", object is UITableView {
            UIView.performWithoutAnimation {
                self.duplicateContactsTblHeight.constant = self.duplicateContactsTbl.contentSize.height
                view.layoutIfNeeded()
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
    
    @IBAction func scanForIssues(_ sender: UIButton) {
        
    }
    
    @IBAction func hideShowDuplicateContacts(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideShowDuplicateContactsBtn.isSelected = sender.isSelected
        if hideShowDuplicateContactsBtn.isSelected {
            if duplicateContactsArray.isEmpty {
                duplicateContactsTbl.isHidden = true
                duplicateContactsEmptyView.isHidden = false
            } else {
                duplicateContactsTbl.isHidden = false
                duplicateContactsEmptyView.isHidden = true
            }
        } else {
            duplicateContactsEmptyView.isHidden = true
            duplicateContactsTbl.isHidden = true
        }
    }
    
    @IBAction func hideShowIncompleteNames(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideShowIncompleteNamesBtn.isSelected = sender.isSelected
        if hideShowIncompleteNamesBtn.isSelected {
            if incompleteNamesArray.isEmpty {
                incompleteNamesListView.isHidden = true
                incompleteNamesEmptyView.isHidden = false
            } else {
                incompleteNamesListView.isHidden = false
                incompleteNamesEmptyView.isHidden = true
            }
            incompleteNamesLbl.isHidden = false
        } else {
            incompleteNamesEmptyView.isHidden = true
            incompleteNamesListView.isHidden = true
            incompleteNamesLbl.isHidden = true
        }
    }
    
    @IBAction func hideShowMissingPhone(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideShowMissingPhoneBtn.isSelected = sender.isSelected
        if hideShowMissingPhoneBtn.isSelected {
            if incompleteNamesArray.isEmpty {
                missingPhoneListView.isHidden = true
                missingPhoneEmptyView.isHidden = false
            } else {
                missingPhoneListView.isHidden = false
                missingPhoneEmptyView.isHidden = true
            }
            missingPhoneNumberLbl.isHidden = false
        } else {
            missingPhoneEmptyView.isHidden = true
            missingPhoneListView.isHidden = true
            missingPhoneNumberLbl.isHidden = true
        }
    }
    
    @IBAction func hideShowMissingEmails(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideShowMissingEmailsBtn.isSelected = sender.isSelected
        if hideShowMissingEmailsBtn.isSelected {
            if incompleteNamesArray.isEmpty {
                missingEmailsListView.isHidden = true
                missingEmailsEmptyView.isHidden = false
            } else {
                missingEmailsListView.isHidden = false
                missingEmailsEmptyView.isHidden = true
            }
            missingEmailAddressLbl.isHidden = false
        } else {
            missingEmailsEmptyView.isHidden = true
            missingEmailsListView.isHidden = true
            missingEmailAddressLbl.isHidden = true
        }
    }
    
    @IBAction func hideShowAddressOnlyContacts(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideShowAddressOnlyContactsBtn.isSelected = sender.isSelected
        if hideShowAddressOnlyContactsBtn.isSelected {
            if incompleteNamesArray.isEmpty {
                addressOnlyContactsListView.isHidden = true
                addressOnlyContactsEmptyView.isHidden = false
            } else {
                addressOnlyContactsListView.isHidden = false
                addressOnlyContactsEmptyView.isHidden = true
            }
            addressOnlyContactsLbl.isHidden = false
        } else {
            addressOnlyContactsEmptyView.isHidden = true
            addressOnlyContactsListView.isHidden = true
            addressOnlyContactsLbl.isHidden = true
        }
    }
    
    @IBAction func selectAllContacts(_ sender: UIButton) {
        if selectedAddressOnlyContacts.isEmpty {
            selectedAddressOnlyContacts = ["Nadia", "Nadia"]
            selectAllIcon.image = UIImage(named: "check-box")
            archiveView.isHidden = false
        } else {
            selectedAddressOnlyContacts.removeAll()
            selectAllIcon.image = UIImage(named: "square")
            archiveView.isHidden = true
        }
        
        addressOnlyContactsTbl.reloadData()
    }
    
    @IBAction func exactNameMatches(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideShowExactNamesBtn.isSelected = sender.isSelected
        if hideShowExactNamesBtn.isSelected {
            exactNamesEmptyView.isHidden = false
            exactNamesMatchesLbl.isHidden = false
        } else {
            exactNamesEmptyView.isHidden = true
            exactNamesMatchesLbl.isHidden = true
        }
    }
    
    @IBAction func emailOnlyContacts(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        hideShowEmailOnlyContactsBtn.isSelected = sender.isSelected
        if hideShowEmailOnlyContactsBtn.isSelected {
            emailOnlyContactsEmptyView.isHidden = false
            emailOnlyContactsLbl.isHidden = false
        } else {
            emailOnlyContactsEmptyView.isHidden = true
            emailOnlyContactsLbl.isHidden = true
        }
    }
    
    fileprivate func hideLbls() {
        exactNamesMatchesLbl.isHidden = true
        emailOnlyContactsLbl.isHidden = true
        incompleteNamesLbl.isHidden = true
        missingPhoneNumberLbl.isHidden = true
        missingEmailAddressLbl.isHidden = true
        addressOnlyContactsLbl.isHidden = true
    }
}

extension CleanUpContactsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == incompleteNamesTbl ||
            tableView == missingPhoneTbl ||
            tableView == missingEmailsTbl ||
            tableView == addressOnlyContactsTbl {
            let cell = tableView.dequeueReusableCell(withIdentifier: IncompleteNameCell.identifier, for: indexPath) as! IncompleteNameCell
            
            cell.checkIcon.isHidden = true
            cell.checkIconWidth.constant = 0
            cell.checkIconLeading.constant = 0
            
            if tableView == addressOnlyContactsTbl {
                cell.checkIcon.isHidden = false
                cell.checkIconWidth.constant = 16
                cell.checkIconLeading.constant = 12
                
                if selectedAddressOnlyContacts.indices.contains(indexPath.row) {
                    if selectedAddressOnlyContacts[indexPath.row] == "Nadia" {
                        cell.checkUncheckIcon.image = UIImage(named: "check-box")
                    } else {
                        cell.checkUncheckIcon.image = UIImage(named: "square")
                    }
                } else {
                    cell.checkUncheckIcon.image = UIImage(named: "square")
                }
            }
            
            cell.editBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            
            cell.editBtn.addTarget(self, action: #selector(editContact(_ :)), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteContact(_ :)), for: .touchUpInside)
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: DuplicateContactCell.identifier, for: indexPath) as! DuplicateContactCell
            
            cell.contactsCollectionView.tag = indexPath.row
            cell.contactsCollectionView.delegate = self
            cell.contactsCollectionView.dataSource = self
            cell.contactsCollectionView.registerCellFromNib(cellID: MergeContactCell.identifier)
            cell.contactsCollectionView.registerCellFromNib(cellID: MergeContactInfoCell.identifier)
            cell.contactsCollectionView.registerCellFromNib(cellID: MergeContactInfo2Cell.identifier)
            cell.contactsCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            cell.contactsCollectionView.reloadData()
            
            cell.mergeBtn.tag = indexPath.row
            cell.mergeBtn.addTarget(self, action: #selector(appearMergeView(_ :)), for: .touchUpInside)
            
            cell.dismissBtn.tag = indexPath.row
            cell.dismissBtn.addTarget(self, action: #selector(dismissMergeView(_ :)), for: .touchUpInside)
            
            cell.cancelBtn.tag = indexPath.row
            cell.cancelBtn.addTarget(self, action: #selector(cancelMerge(_ :)), for: .touchUpInside)
            
            cell.confirmMergeBtn.tag = indexPath.row
            cell.confirmMergeBtn.addTarget(self, action: #selector(confirmMerge(_ :)), for: .touchUpInside)
            
            let details = duplicateContactsArray[indexPath.row]
            
            cell.mergeView.isHidden = true
            cell.dismissView.isHidden = false
            cell.cancelView.isHidden = true
            cell.confirmMergeView.isHidden = true
            cell.bottomView.isHidden = true
            
            if details.event == .normal {
                cell.mergeView.isHidden = false
                cell.collectionViewHeight.constant = 125
            } else {
                cell.mergeView.isHidden = true
                cell.cancelView.isHidden = false
                cell.confirmMergeView.isHidden = false
                cell.confirmMergeLbl.text = "Confirm Merge"
                cell.collectionViewHeight.constant = 150
                cell.bottomView.isHidden = false
            }
            
            return cell
        }
    }
    
    @objc fileprivate func editContact(_ sender: UIButton) {
        let storyboard = AppStoryboards.main.storyboardInstance
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "CompleteContactInfoVC") as? CompleteContactInfoVC
        else { return }
        SharedMethods.shared.presentVC(destVC: destVC, modalPresentationStyle: .overFullScreen)
    }
    
    @objc fileprivate func deleteContact(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func appearMergeView(_ sender: UIButton) {
        duplicateContactsArray[sender.tag].event = .merge
        duplicateContactsTbl.reloadRows(at: [IndexPath(row: sender.tag, section: 0)],
                                        with: .automatic)
    }
    
    @objc fileprivate func dismissMergeView(_ sender: UIButton) {
        duplicateContactsArray[sender.tag].event = .normal
        duplicateContactsTbl.reloadRows(at: [IndexPath(row: sender.tag, section: 0)],
                                        with: .automatic)
    }
    
    @objc fileprivate func cancelMerge(_ sender: UIButton) {
        duplicateContactsArray[sender.tag].event = .normal
        duplicateContactsTbl.reloadRows(at: [IndexPath(row: sender.tag, section: 0)],
                                        with: .automatic)
    }
    
    @objc fileprivate func confirmMerge(_ sender: UIButton) {
        if let cell = duplicateContactsTbl.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? DuplicateContactCell {
            cell.confirmMergeLbl.text = "Merging..."
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.duplicateContactsArray[sender.tag].event = .normal
            self?.duplicateContactsTbl.reloadRows(at: [IndexPath(row: sender.tag, section: 0)],
                                                  with: .automatic)
        }
    }
}

extension CleanUpContactsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        return duplicateContactsArray[tag].info.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if duplicateContactsArray[collectionView.tag].event == .normal {
            return CGSize(width: width, height: 125)
        } else {
            return CGSize(width: width, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if duplicateContactsArray[collectionView.tag].event == .normal {
            return 10
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let details = duplicateContactsArray[collectionView.tag]
        if details.event == .normal {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MergeContactCell.identifier, for: indexPath) as! MergeContactCell
            return cell
        } else {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MergeContactInfoCell.identifier, for: indexPath) as! MergeContactInfoCell
                
                let section = collectionView.tag
                let row = indexPath.row
                let tag = section * 1000 + row
                
                cell.nameBtn.tag = tag
                cell.phoneBtn.tag = tag
                cell.companyBtn.tag = tag
                
                cell.nameBtn.addTarget(self, action: #selector(handleNameBtn(_ :)), for: .touchUpInside)
                cell.phoneBtn.addTarget(self, action: #selector(handlePhoneBtn(_ :)), for: .touchUpInside)
                cell.companyBtn.addTarget(self, action: #selector(handleCompanyBtn(_ :)), for: .touchUpInside)
                
                let details = duplicateContactsArray[collectionView.tag].info[indexPath.row]
                
                if details.isNameChoose {
                    cell.nameIcon.image = UIImage(named: "correct")
                    cell.nameView.backgroundColor = UIColor(named: "#155DC1_10")
                } else {
                    cell.nameIcon.image = UIImage(named: "dry-clean")
                    cell.nameView.backgroundColor = .clear
                }
                
                if details.isPhoneChoose {
                    cell.phoneIcon.image = UIImage(named: "correct")
                    cell.phoneView.backgroundColor = UIColor(named: "#155DC1_10")
                } else {
                    cell.phoneIcon.image = UIImage(named: "dry-clean")
                    cell.phoneView.backgroundColor = .clear
                }
                
                if details.isCompanyChoose {
                    cell.companyIcon.image = UIImage(named: "correct")
                    cell.companyView.backgroundColor = UIColor(named: "#155DC1_10")
                } else {
                    cell.companyIcon.image = UIImage(named: "dry-clean")
                    cell.companyView.backgroundColor = .clear
                }
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MergeContactInfo2Cell.identifier, for: indexPath) as! MergeContactInfo2Cell
                
                let section = collectionView.tag
                let row = indexPath.row
                let tag = section * 1000 + row
                
                cell.nameBtn.tag = tag
                cell.phoneBtn.tag = tag
                cell.companyBtn.tag = tag
                
                cell.nameBtn.addTarget(self, action: #selector(handleNameBtn(_ :)), for: .touchUpInside)
                cell.phoneBtn.addTarget(self, action: #selector(handlePhoneBtn(_ :)), for: .touchUpInside)
                cell.companyBtn.addTarget(self, action: #selector(handleCompanyBtn(_ :)), for: .touchUpInside)
                
                let details = duplicateContactsArray[collectionView.tag].info[indexPath.row]
                
                if details.isNameChoose {
                    cell.nameIcon.image = UIImage(named: "correct")
                    cell.nameView.backgroundColor = UIColor(named: "#155DC1_10")
                } else {
                    cell.nameIcon.image = UIImage(named: "dry-clean")
                    cell.nameView.backgroundColor = .clear
                }
                
                if details.isPhoneChoose {
                    cell.phoneIcon.image = UIImage(named: "correct")
                    cell.phoneView.backgroundColor = UIColor(named: "#155DC1_10")
                } else {
                    cell.phoneIcon.image = UIImage(named: "dry-clean")
                    cell.phoneView.backgroundColor = .clear
                }
                
                if details.isCompanyChoose {
                    cell.companyIcon.image = UIImage(named: "correct")
                    cell.companyView.backgroundColor = UIColor(named: "#155DC1_10")
                } else {
                    cell.companyIcon.image = UIImage(named: "dry-clean")
                    cell.companyView.backgroundColor = .clear
                }
                
                return cell
            }
        }
    }
    
    @objc fileprivate func handleNameBtn(_ sender: UIButton) {
        let tag = sender.tag
        let section = tag / 1000
        let row = tag % 1000
        
        let status = duplicateContactsArray[section].info[row].isNameChoose
        
        let info = duplicateContactsArray[section].info
        let updatedInfo = info.map {
            var item = $0
            item.isNameChoose = false
            return item
        }
        
        duplicateContactsArray[section].info = updatedInfo
        
        if status {
            duplicateContactsArray[section].info[row].isNameChoose = false
        } else {
            duplicateContactsArray[section].info[row].isNameChoose = true
        }
        
        if let cell = duplicateContactsTbl.cellForRow(at: IndexPath(row: section, section: 0)) as? DuplicateContactCell {
            //cell.contactsCollectionView.reloadItems(at: [IndexPath(item: row, section: section)])
            cell.contactsCollectionView.reloadData()
        }
    }
    
    @objc fileprivate func handlePhoneBtn(_ sender: UIButton) {
        let tag = sender.tag
        let section = tag / 1000
        let row = tag % 1000
        
        let status = duplicateContactsArray[section].info[row].isPhoneChoose
        
        let info = duplicateContactsArray[section].info
        let updatedInfo = info.map {
            var item = $0
            item.isPhoneChoose = false
            return item
        }
        
        duplicateContactsArray[section].info = updatedInfo
        
        if status {
            duplicateContactsArray[section].info[row].isPhoneChoose = false
        } else {
            duplicateContactsArray[section].info[row].isPhoneChoose = true
        }
        
        if let cell = duplicateContactsTbl.cellForRow(at: IndexPath(row: section, section: 0)) as? DuplicateContactCell {
            //cell.contactsCollectionView.reloadItems(at: [IndexPath(item: row, section: section)])
            cell.contactsCollectionView.reloadData()
        }
    }
    
    @objc fileprivate func handleCompanyBtn(_ sender: UIButton) {
        let tag = sender.tag
        let section = tag / 1000
        let row = tag % 1000
        
        let status = duplicateContactsArray[section].info[row].isCompanyChoose
        
        let info = duplicateContactsArray[section].info
        let updatedInfo = info.map {
            var item = $0
            item.isCompanyChoose = false
            return item
        }
        
        duplicateContactsArray[section].info = updatedInfo
        
        if status {
            duplicateContactsArray[section].info[row].isCompanyChoose = false
        } else {
            duplicateContactsArray[section].info[row].isCompanyChoose = true
        }
        
        if let cell = duplicateContactsTbl.cellForRow(at: IndexPath(row: section, section: 0)) as? DuplicateContactCell {
            //cell.contactsCollectionView.reloadItems(at: [IndexPath(item: row, section: section)])
            cell.contactsCollectionView.reloadData()
        }
    }
}
