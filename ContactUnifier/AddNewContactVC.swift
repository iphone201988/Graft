import UIKit
import SideMenu

class AddNewContactVC: UIViewController {
    
    @IBOutlet weak var fn: OpenSansTF!
    @IBOutlet weak var ln: OpenSansTF!
    @IBOutlet weak var email: OpenSansTF!
    @IBOutlet weak var phone: OpenSansTF!
    @IBOutlet weak var company: OpenSansTF!
    @IBOutlet weak var jobTitle: OpenSansTF!
    @IBOutlet weak var street: OpenSansTF!
    @IBOutlet weak var city: OpenSansTF!
    @IBOutlet weak var state: OpenSansTF!
    @IBOutlet weak var zip: OpenSansTF!
    @IBOutlet weak var country: OpenSansTF!
    @IBOutlet weak var dobBtn: UIButton!
    @IBOutlet weak var dobTF: OpenSansTF!
    @IBOutlet weak var notes: OpenSansTV!
    
    var servicesEvents: ServicesEvents?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
    }
    
    @IBAction func closeForm(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func createContact(_ sender: UIButton) {
        let firstName = fn.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let lastName = ln.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let phoneNumber = phone.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let companyName = company.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let jobTitle = jobTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let streetAddress = street.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let city = city.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let state = state.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let zipCode = zip.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let country = country.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let dob = dobTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let notes = notes.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || phoneNumber.isEmpty {
            Toast.show(message: "First Name, Last Name, Email, and Phone Number are required.")
        } else {
            if email.isEmail {
                if phoneNumber.isPhoneNumber {
                    dismiss(animated: true) {
                        let fullname = "\(firstName ?? "") \(lastName ?? "")"
                        let initials = SharedMethods.shared.getInitials(from: fullname)
                        let info = NewContactInfo(firstName: firstName,
                                                  lastName: lastName,
                                                  email: email,
                                                  phoneNumber: phoneNumber,
                                                  company: companyName,
                                                  jobTitle: jobTitle,
                                                  street: streetAddress,
                                                  city: city,
                                                  state: state,
                                                  zip: zipCode,
                                                  country: country,
                                                  birthday: dob,
                                                  note: notes,
                                                  initials: initials)
                        self.servicesEvents?.createdContact(info: info)
                    }
                } else {
                    Toast.show(message: "Please enter a valid phone number.")
                }
            } else {
                Toast.show(message: "Please enter a valid email address.")
            }
        }
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
