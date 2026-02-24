import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var tagIcon: UIImageView!
    @IBOutlet weak var tagLbl: OpenSansLbl!
    @IBOutlet weak var subTagLbl: OpenSansLbl!
    @IBOutlet weak var contactCountLbl: OpenSansLbl!
    
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
