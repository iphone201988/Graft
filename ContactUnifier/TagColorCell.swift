import UIKit

class TagColorCell: UICollectionViewCell {
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagIcon: UIImageView!
    
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
