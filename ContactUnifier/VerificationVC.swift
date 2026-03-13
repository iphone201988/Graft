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
        otp1.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otp2.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otp3.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otp4.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        otp1.becomeFirstResponder()
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
                let params = ["email": emailValue,
                              "otp": code,
                              "type": ForgotPasswordEvents.verifyCode.rawValue] as [String : Any]
                Task {
                    await accountVerify(params)
                }
            }
        }
    }
    
    @IBAction func resendCode(_ sender: UIButton) {
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        if text.count >= 1 && text.count < 2 {
            switch textField {
            case otp1: otp2.becomeFirstResponder()
            case otp2: otp3.becomeFirstResponder()
            case otp3: otp4.becomeFirstResponder()
            case otp4: otp4.resignFirstResponder()
            default: break
            }
        } else if text.isEmpty {
            textField.text = " "
            switch textField {
            case otp1: otp1.becomeFirstResponder()
            case otp2: otp1.becomeFirstResponder()
            case otp3: otp2.becomeFirstResponder()
            case otp4: otp3.becomeFirstResponder()
            default: break
            }
        } else {
            if let lastCharacter = text.last {
                textField.text = String(lastCharacter)
                switch textField {
                case otp1: otp2.becomeFirstResponder()
                case otp2: otp3.becomeFirstResponder()
                case otp3: otp4.becomeFirstResponder()
                case otp4: otp4.resignFirstResponder()
                default: break
                }
            }
        }
    }
}

extension VerificationVC {
    fileprivate func accountVerify(_ params: [String: Any]) async {
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
                Toast.show(message: "Verified successfully") {
                    let sb = AppStoryboards.main.storyboardInstance
                    let destVC = sb.instantiateViewController(withIdentifier: "CreateNewPasswordVC") as! CreateNewPasswordVC
                    destVC.emailValue = self.emailValue
                    destVC.tokenData = details
                    SharedMethods.shared.pushTo(destVC: destVC)
                }
            }
        }
    }
}
