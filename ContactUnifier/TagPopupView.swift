import UIKit

class TagPopupView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tags: [[String: Any]] = []
    var selectedTag: [String: Any]?
    var didSelectTag: (([String: Any]) -> Void)?
    
    private let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: "#E6E7E9")
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 45
        tableView.layer.cornerRadius = 12
        tableView.backgroundColor = UIColor(named: "#E6E7E9")
        tableView.registerCellFromNib(cellID: TagCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.identifier, for: indexPath) as! TagCell
        let tag = tags[indexPath.row]
        cell.tagLbl.text = tag["tag"] as? String ?? ""
        let colorName = tag["color"] as? String ?? ""
        cell.tagIcon.tintColor = UIColor(named: colorName)
        if colorName.isEmpty {
            cell.tagWidth.constant = 0.0
            cell.tagTrailing.constant = 0.0
        } else {
            cell.tagWidth.constant = 16.0
            cell.tagTrailing.constant = 10.0
        }
        let selectedTagValue = selectedTag?["tag"] as? String ?? ""
        if selectedTagValue == tag["tag"] as? String ?? "" {
            cell.selectedIcon.isHidden = false
        } else {
            cell.selectedIcon.isHidden = true
        }
        
        //cell.backgroundColor = UIColor(named: "#E6E7E9")
        return cell
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        selectedTag = tag
        didSelectTag?(tag)
    }
}
