import UIKit

class UserCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var initalLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var initialView: UIView!
    @IBOutlet weak var starIcon: UIImageView!
    @IBOutlet weak var dayView: UIView!
    
    // MARK: Variables
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Shared Methods
    
    // MARK: IB Actions
}
