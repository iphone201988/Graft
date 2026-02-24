import UIKit
import SideMenu

class AddNewContactVC: UIViewController {
    
    @IBOutlet weak var dobBtn: UIButton!
    @IBOutlet weak var dobTF: OpenSansTF!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    
    @IBAction func closeForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func createContact(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func chooseDOB(_ sender: UIButton) {
        dobTF.becomeFirstResponder()
    }
    
    func setupDatePicker() {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneDatePicker))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: nil,
                                    action: nil)
        
        toolbar.setItems([space, doneButton], animated: false)
        
        dobTF.inputView = datePicker
        dobTF.inputAccessoryView = toolbar
    }
    
    @objc func doneDatePicker() {
        
        if let datePicker = dobTF.inputView as? UIDatePicker {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            dobTF.text = formatter.string(from: datePicker.date)
        }
        
        dobTF.resignFirstResponder()
    }
}
