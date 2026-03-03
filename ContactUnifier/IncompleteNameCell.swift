import UIKit

class IncompleteNameCell: UITableViewCell {

    @IBOutlet weak var checkIconWidth: NSLayoutConstraint!
    @IBOutlet weak var checkIcon: UIView!
    @IBOutlet weak var emailView: UIStackView!
    @IBOutlet weak var phoneView: UIStackView!
    @IBOutlet weak var companyView: UIStackView!
    @IBOutlet weak var checkUncheckIcon: UIImageView!
    @IBOutlet weak var checkIconLeading: NSLayoutConstraint!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
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
