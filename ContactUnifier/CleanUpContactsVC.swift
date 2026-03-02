import UIKit
import SideMenu

class CleanUpContactsVC: UIViewController {
    
    @IBOutlet weak var duplicateContactsTbl: UITableView! {
        didSet {
            duplicateContactsTbl.showsVerticalScrollIndicator = false
            duplicateContactsTbl.showsHorizontalScrollIndicator = false
            duplicateContactsTbl.registerCellFromNib(cellID: DuplicateContactCell.identifier)
        }
    }
    
    @IBOutlet weak var duplicateContactsEmptyView: UIView!
    @IBOutlet weak var hideShowDuplicateContactsBtn: UIButton!
    
    var duplicateContactsArray = [ContactInfo]()
    
    var names = [["Nadia", "Nadina"],
                 ["Melissa Schwartz", "Tessa Schwartz"],
                 ["Maddie", "Maddy Jimerson"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideShowDuplicateContactsBtn.isSelected = false
        duplicateContactsEmptyView.isHidden = true
        duplicateContactsTbl.isHidden = true
        
        for name in names {
            let info1 = MergeContacts(event: .normal,
                                      name: "Nadia",
                                      source: "vcard",
                                      phone: "+1 (317)610-6442",
                                      email: "nadia@gmail.com",
                                      company: "Kohls/Macys")
            
            let info2 = MergeContacts(event: .normal,
                                      name: "Nadia",
                                      source: "vcard",
                                      phone: "+1 (317)610-6442",
                                      email: "nadia@gmail.com",
                                      company: "Kohls/Macys")
            
            let contactInfo = ContactInfo(total: 2, info: [info1, info2])
            duplicateContactsArray.append(contactInfo)
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
}

extension CleanUpContactsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        duplicateContactsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DuplicateContactCell.identifier, for: indexPath) as! DuplicateContactCell
        
        cell.contactsCollectionView.delegate = self
        cell.contactsCollectionView.dataSource = self
        cell.contactsCollectionView.registerCellFromNib(cellID: MergeContactCell.identifier)
        cell.contactsCollectionView.reloadData()
        
        cell.mergeBtn.tag = indexPath.row
        cell.mergeBtn.addTarget(self, action: #selector(appearMergeView(_ :)), for: .touchUpInside)
        
        cell.dismissBtn.tag = indexPath.row
        cell.dismissBtn.addTarget(self, action: #selector(dismissMergeView(_ :)), for: .touchUpInside)
        
        return cell
    }
    
    @objc fileprivate func appearMergeView(_ sender: UIButton) {
        
    }
    
    @objc fileprivate func dismissMergeView(_ sender: UIButton) {
        
    }
}

extension CleanUpContactsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = duplicateContactsTbl.frame.width - 100
        print("width: \(width)")
        return CGSize(width: 200, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MergeContactCell.identifier, for: indexPath) as! MergeContactCell
        return cell
    }
}

enum MergeContactEvents {
    case normal
    case merge
}

struct MergeContacts {
    var event: MergeContactEvents = .normal
    var name: String
    var source: String
    var phone: String?
    var email: String?
    var company: String?
}

struct ContactInfo {
    var total: Int
    var info: [MergeContacts]
}

struct Contacts {
    var data: [ContactInfo]
}
