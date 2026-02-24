import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var sourceLbl: OpenSansLbl!
    @IBOutlet weak var sourceView: UIView!
    @IBOutlet weak var nameView: UIStackView!
    @IBOutlet weak var emailView: UIStackView!
    @IBOutlet weak var contactView: UIStackView!
    @IBOutlet weak var companyView: UIStackView!
    @IBOutlet weak var companyTopView: UIView!
    
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
