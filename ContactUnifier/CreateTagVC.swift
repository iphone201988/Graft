import UIKit

class CreateTagVC: UIViewController {
    
    @IBOutlet weak var name: OpenSansTF!
    @IBOutlet weak var notes: OpenSansTV!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellFromNib(cellID: TagColorCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }

    var tagColors = Set<ColorData>()
    var selectedTagColor: ColorData?
    var servicesEvents: ServicesEvents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func createTag(_ sender: UIButton) {
        dismiss(animated: true) {
            let info = NewAddingInfo(tagName: self.name.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "",
                                     tagDesc: self.notes.text.trimmingCharacters(in: .whitespacesAndNewlines),
                                     tagColorID: "\(self.selectedTagColor?.id ?? 0)",
                                     tagHexaColor: self.selectedTagColor?.code ?? "")
            self.servicesEvents?.createdTag(info: info)
        }
    }
}

extension CreateTagVC: UICollectionViewDataSource,
                       UICollectionViewDelegate,
                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tagColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagColorCell.identifier, for: indexPath) as! TagColorCell
        let tagsArray = Array(tagColors)
        let tag = tagsArray[indexPath.row]
        cell.tagIcon.tintColor = UIColor(hex: tag.code ?? "")
        if selectedTagColor?.code == tag.code ?? "" {
            cell.tagView.borderWidth = 2
        } else {
            cell.tagView.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tagsArray = Array(tagColors)
        selectedTagColor = tagsArray[indexPath.row]
        self.collectionView.reloadData()
    }
}
