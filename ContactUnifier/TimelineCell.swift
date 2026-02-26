import UIKit

class TimelineCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: OpenSansLbl!
    @IBOutlet weak var type: OpenSansLbl!
    @IBOutlet weak var source: OpenSansLbl!
    @IBOutlet weak var remark: OpenSansLbl!
    @IBOutlet weak var time: OpenSansLbl!
    
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
