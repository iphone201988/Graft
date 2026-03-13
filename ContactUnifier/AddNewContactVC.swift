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
    @IBOutlet weak var titleLbl: OpenSansLbl!
    @IBOutlet weak var createContactBtnTitle: UILabel!
    
    var servicesEvents: ServicesEvents?
    var interfaceTitle = "Add New Contact"
    var birthdayParam = ""
    var contactDetails: ContactData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        titleLbl.text = interfaceTitle
        if interfaceTitle == "Add New Contact" {
            createContactBtnTitle.text = "Create Contact"
        } else {
            createContactBtnTitle.text = "Update Contact"
        }
        
        if let _ = contactDetails {
            populateData()
        }
    }
    
    fileprivate func populateData() {
        fn.text = contactDetails?.first_name ?? ""
        ln.text = contactDetails?.last_name ?? ""
        email.text = contactDetails?.primary_email ?? ""
        phone.text = contactDetails?.primary_phone ?? ""
        company.text = contactDetails?.company ?? ""
        jobTitle.text = contactDetails?.job_title ?? ""
        if let address = contactDetails?.addresses?.first {
            street.text = address.street ?? ""
            city.text = address.city ?? ""
            state.text = address.state ?? ""
            zip.text = address.zip_code ?? ""
            country.text = address.country ?? ""
        }
        
        dobTF.text = SharedMethods.shared.formatDOB(contactDetails?.birthday)
        birthdayParam = contactDetails?.birthday ?? ""
        notes.text = contactDetails?.note ?? ""
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
        let _ = dobTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let notes = notes.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if firstName.isEmpty || lastName.isEmpty || email.isEmpty || phoneNumber.isEmpty {
            Toast.show(message: "First Name, Last Name, Email, and Phone Number are required.")
        } else {
            if email.isEmail {
                if phoneNumber.isPhoneNumber {
                    dismiss(animated: true) {
                        let fullname = "\(firstName) \(lastName)"
                        let initials = SharedMethods.shared.getInitials(from: fullname)
                        var existingContactID: String? = nil
                        
                        if let details = self.contactDetails {
                            existingContactID = "\(details.id ?? 0)"
                        }
                        
                        let info = NewAddingInfo(firstName: firstName,
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
                                                 birthday: self.birthdayParam,
                                                 note: notes,
                                                 initials: initials,
                                                 existingContactID: existingContactID)
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
            formatter.dateFormat = "yyyy-MM-dd" //"1985-03-15"
            birthdayParam = formatter.string(from: datePicker.date)
        }
        
        dobTF.resignFirstResponder()
    }
}
