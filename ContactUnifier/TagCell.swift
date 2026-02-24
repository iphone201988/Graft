import UIKit

class TagCell: UITableViewCell {

    @IBOutlet weak var selectedIcon: UIImageView!
    @IBOutlet weak var tagIcon: UIImageView!
    @IBOutlet weak var tagLbl: OpenSansLbl!
    @IBOutlet weak var tagWidth: NSLayoutConstraint!
    @IBOutlet weak var tagTrailing: NSLayoutConstraint!
    
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
