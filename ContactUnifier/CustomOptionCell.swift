import UIKit

class CustomOptionCell: UICollectionViewCell {

    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var eyeIcon: UIImageView!
    @IBOutlet weak var title: OpenSansLbl!
    @IBOutlet weak var iconWidth: NSLayoutConstraint!
    @IBOutlet weak var iconSpacing: NSLayoutConstraint!
    
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

}
