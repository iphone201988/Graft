import UIKit

class VerificationVC: UIViewController {
    
    @IBOutlet weak var email: OpenSansLbl!
    
    @IBOutlet weak var otp1: OpenSansTF!
    @IBOutlet weak var otp2: OpenSansTF!
    @IBOutlet weak var otp3: OpenSansTF!
    @IBOutlet weak var otp4: OpenSansTF!
    
    var emailValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.text = emailValue
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func verifyCode(_ sender: UIButton) {
        let otp1Value = otp1.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let otp2Value = otp2.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let otp3Value = otp3.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let otp4Value = otp4.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let code = otp1Value + otp2Value + otp3Value + otp4Value
        if code.isEmpty {
            Toast.show(message: "Code can't be empty")
        } else  {
            if code.count != 4 {
                Toast.show(message: "Please enter valid code")
            } else {
                Toast.show(message: "Verified successfully") {
                    let sb = AppStoryboards.main.storyboardInstance
                    let destVC = sb.instantiateViewController(withIdentifier: "CreateNewPasswordVC") as! CreateNewPasswordVC
                    destVC.emailValue = self.emailValue
                    SharedMethods.shared.pushTo(destVC: destVC)
                }
            }
        }
    }
    
    @IBAction func resendCode(_ sender: UIButton) {
        
    }
}

