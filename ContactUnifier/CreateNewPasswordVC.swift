import UIKit

class CreateNewPasswordVC: UIViewController {
    
    @IBOutlet weak var password: OpenSansTF!
    @IBOutlet weak var confirmPassword: OpenSansTF!
    @IBOutlet weak var passwordBtn: UIButton!
    @IBOutlet weak var confirmPasswordBtn: UIButton!
    
    var emailValue = ""
    var tokenData: TokenData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordBtn.isSelected = false
        confirmPasswordBtn.isSelected = false
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func createPassword(_ sender: UIButton) {
        let password = password.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let confirmPassword = confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if !password.isEmpty && !confirmPassword.isEmpty {
            if password != confirmPassword {
                Toast.show(message: "Password does not match i.e. Password & Confirm Password should be same")
            } else {
                let params = ["email": emailValue,
                              "type": ForgotPasswordEvents.changePassword.rawValue,
                              "token": tokenData?.data ?? "",
                              "password": password,
                              "confirm_password": password] as [String : Any]
                Task {
                    await resetPassword(params)
                }
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

extension CreateNewPasswordVC {
    fileprivate func resetPassword(_ params: [String: Any]) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .forgotPassword,
                                                             model: TokenData.self,
                                                             params: params,
                                                             method: .post,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success(let details):
                Toast.show(message: "New password created successfully") {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
    }
}
