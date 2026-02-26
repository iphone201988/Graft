import UIKit

class LostTouchCell: UITableViewCell {
    
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var initialLbl: OpenSansLbl!
    @IBOutlet weak var name: OpenSansLbl!
    @IBOutlet weak var company: OpenSansLbl!
    @IBOutlet weak var email: OpenSansLbl!
    @IBOutlet weak var emailView: UIStackView!
    @IBOutlet weak var about: OpenSansLbl!
    @IBOutlet weak var days: OpenSansLbl!
    @IBOutlet weak var companyTop: UIView!
    @IBOutlet weak var emailTop: UIView!
    @IBOutlet weak var companyView: UIStackView!
    @IBOutlet weak var contentViewTop: NSLayoutConstraint!
    
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
