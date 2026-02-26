import UIKit

class CreateTagVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerCellFromNib(cellID: TagColorCell.identifier)
            collectionView.showsVerticalScrollIndicator = false
            collectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    let tags = [
        
        // Top Row
        ["tag": "blue",        "color": "#3B82F6"],
        ["tag": "purple",      "color": "#8B5CF6"],
        ["tag": "pink",        "color": "#EC4899"],
        ["tag": "green",       "color": "#10B981"],
        ["tag": "amber",       "color": "#F59E0B"],
        ["tag": "red",         "color": "#EF4444"],
        ["tag": "cyan",        "color": "#06B6D4"],
        ["tag": "lime",        "color": "#84CC16"],
        
        // Bottom Row
        ["tag": "orange",      "color": "#F97316"],
        ["tag": "teal",        "color": "#14B8A6"],
        ["tag": "violet",      "color": "#A855F7"],
        ["tag": "indigo",      "color": "#6366F1"],
        ["tag": "magenta",     "color": "#D946EF"],
        ["tag": "sky blue",    "color": "#0EA5E9"],
        ["tag": "gray",        "color": "#64748B"]
    ]
    
    var selectedTagColor = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func createTag(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

extension CreateTagVC: UICollectionViewDataSource,
                       UICollectionViewDelegate,
                       UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
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
        let tag = tags[indexPath.row]
        let color = tag["color"] ?? ""
        cell.tagIcon.tintColor = UIColor(named: tag["color"] ?? "")
        if selectedTagColor == color {
            cell.tagView.borderWidth = 2
        } else {
            cell.tagView.borderWidth = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        selectedTagColor = tag["color"] ?? ""
        self.collectionView.reloadData()
    }
}
