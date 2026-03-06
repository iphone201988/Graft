import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTF: OpenSansTF!
    @IBOutlet weak var email: OpenSansTF!
    @IBOutlet weak var password: OpenSansTF!
    @IBOutlet weak var confirmPassword: OpenSansTF!
    @IBOutlet weak var termsConditionsLbl: OpenSansLbl!
    @IBOutlet weak var passwordBtn: UIButton!
    @IBOutlet weak var confirmPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let text = "By continuing you agree to Graft Terms & Conditions and Privacy Policy"
        let attributedText = NSMutableAttributedString(string: text)
        
        // Custom font
        let regularFont = UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .medium)
        let semiBoldFont = UIFont(name: "OpenSans-SemiBold", size: 12) ?? .systemFont(ofSize: 12, weight: .semibold)
        
        // Apply default style
        attributedText.addAttributes([
            .font: regularFont,
            .foregroundColor: UIColor.black
        ], range: NSRange(location: 0, length: text.count))
        
        // Terms range
        let termsRange = (text as NSString).range(of: "Terms & Conditions")
        attributedText.addAttributes([
            .font: semiBoldFont,
            .foregroundColor: UIColor.black
        ], range: termsRange)
        
        // Privacy range
        let privacyRange = (text as NSString).range(of: "Privacy Policy")
        attributedText.addAttributes([
            .font: semiBoldFont,
            .foregroundColor: UIColor.black
        ], range: privacyRange)
        
        termsConditionsLbl.attributedText = attributedText
        
        // Add tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        termsConditionsLbl.addGestureRecognizer(tap)
        
        passwordBtn.isSelected = false
        confirmPasswordBtn.isSelected = false
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel,
              let text = label.attributedText?.string else { return }
        
        let termsRange = (text as NSString).range(of: "Terms & Conditions")
        let privacyRange = (text as NSString).range(of: "Privacy Policy")
        
        if gesture.didTapAttributedTextInLabel(label: label, inRange: termsRange) {
            print("Terms tapped")
        } else if gesture.didTapAttributedTextInLabel(label: label, inRange: privacyRange) {
            print("Privacy tapped")
        }
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        
        let name = nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = password.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let confirmPassword = confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if !name.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty {
            if email.isEmail {
                if password != confirmPassword {
                    Toast.show(message: "Password does not match i.e. Password & Confirm Password should be same")
                } else {
                    if let vc = AppStoryboards.main.controller(DashboardVC.self) {
                        SharedMethods.shared.navigateToRootVC(rootVC: vc)
                    }
                }
            } else {
                Toast.show(message: "Please enter valid email")
            }
        } else {
            Toast.show(message: "All fields are required")
        }
    }
    
    @IBAction func hideShowPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordBtn.isSelected = sender.isSelected
        if passwordBtn.isSelected {
            password.isSecureTextEntry = true
        } else {
            password.isSecureTextEntry = false
        }
    }
    
    @IBAction func hideShowConfirmPassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        confirmPasswordBtn.isSelected = sender.isSelected
        if confirmPasswordBtn.isSelected {
            confirmPassword.isSecureTextEntry = true
        } else {
            confirmPassword.isSecureTextEntry = false
        }
    }
}
