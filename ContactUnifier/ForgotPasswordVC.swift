import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var email: OpenSansTF!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func sentCode(_ sender: UIButton) {
        let email = email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if email.isEmpty {
            Toast.show(message: "Email field can't be empty")
        } else {
            if !email.isEmail {
                Toast.show(message: "Please enter valid email")
            } else {
                Toast.show(message: "Code is sent to your email") {
                    let sb = AppStoryboards.main.storyboardInstance
                    let destVC = sb.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                    destVC.emailValue = email
                    SharedMethods.shared.pushTo(destVC: destVC)
                }
            }
        }
    }
}
