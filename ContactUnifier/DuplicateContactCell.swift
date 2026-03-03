import UIKit

class DuplicateContactCell: UITableViewCell {

    @IBOutlet weak var mergeBtn: UIButton!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var contactsCollectionView: UICollectionView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var confirmMergeBtn: UIButton!
    @IBOutlet weak var mergeView: UIView!
    @IBOutlet weak var dismissView: UIView!
    @IBOutlet weak var cancelView: UIView!
    @IBOutlet weak var confirmMergeView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var confirmMergeLbl: OpenSansLbl!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
