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
                let params = ["email": email, "type": ForgotPasswordEvents.sendCode.rawValue] as [String : Any]
                Task { await forgotPassword(params) }
            }
        }
    }
}

extension ForgotPasswordVC {
    fileprivate func forgotPassword(_ params: [String: Any]) async {
        let res = await RemoteRequestManager.shared.dataTask(endpoint: .forgotPassword,
                                                             model: UserModel.self,
                                                             params: params,
                                                             method: .post,
                                                             body: .rawJSON)
        await MainActor.run {
            switch res {
            case .failure(let err):
                Toast.show(message: err.localizedDescription)
                
            case .success:
                Toast.show(message: "Code is sent to your email") {
                    let sb = AppStoryboards.main.storyboardInstance
                    let destVC = sb.instantiateViewController(withIdentifier: "VerificationVC") as! VerificationVC
                    destVC.emailValue = self.email.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                    SharedMethods.shared.pushTo(destVC: destVC)
                }
            }
        }
    }
}
