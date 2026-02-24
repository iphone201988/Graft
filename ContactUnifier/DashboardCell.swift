import UIKit

class DashboardCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var optionView: UIView!
    @IBOutlet weak var titleLbl1: UILabel!
    @IBOutlet weak var titleLbl2: UILabel!
    @IBOutlet weak var titleLbl3: UILabel!
    @IBOutlet weak var icon: UIImageView!

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
