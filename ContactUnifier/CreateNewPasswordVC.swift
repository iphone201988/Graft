import UIKit

class CreateNewPasswordVC: UIViewController {
    
    @IBOutlet weak var password: OpenSansTF!
    @IBOutlet weak var confirmPassword: OpenSansTF!
    @IBOutlet weak var passwordBtn: UIButton!
    @IBOutlet weak var confirmPasswordBtn: UIButton!
    
    var emailValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordBtn.isSelected = false
        confirmPasswordBtn.isSelected = false
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func createPassword(_ sender: UIButton) {
        Toast.show(message: "New password created successfully") {
            self.navigationController?.popToRootViewController(animated: true)
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
