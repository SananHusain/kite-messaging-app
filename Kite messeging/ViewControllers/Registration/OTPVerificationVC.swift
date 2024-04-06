//
//  OTPVerificationViewController.swift
//  Kite messeging
//
//  Created by Admin on 18/03/24.
//
import UIKit

class OTPVerificationVC: UIViewController {
    
    var Udata = MyDetails.shared
    var userData: UserData?
    var otpTextFields: [UITextField]!
    var timer: Timer!
    var countdownSeconds = 30
    
    @IBOutlet weak var otpField1: UITextField!
    @IBOutlet weak var otpField2: UITextField!
    @IBOutlet weak var otpField3: UITextField!
    @IBOutlet weak var otpField4: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var warningLbl: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var numberLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    @IBAction func actionButtonHit(_ sender: UIButton) {
        // Check if all OTP fields are filled
           let isAllFieldsFilled = otpTextFields.allSatisfy { $0.hasText }
           
           if isAllFieldsFilled {
               // Hide warning label if all OTP fields are filled
               warningLbl.isHidden = true
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
             navigationController?.pushViewController(vc, animated: true)
               
               // Perform verification logic or navigate to the next screen
           } else {
               // Show warning label if all OTP fields are not filled
               warningLbl.isHidden = false
               
             
          }
    }
    @IBAction func resendBtnHit(_ sender: UIButton) {
        sender.isEnabled = false
        startTimer()
            }
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            timerLbl.isHidden = false
            resendBtn.isHidden = true
            updateTime()
        }
        
        @objc func updateTime() {
            timerLbl.text = timeFormatted(countdownSeconds)
            if countdownSeconds != 0 {
                countdownSeconds -= 1
            } else {
                endTimer()
            }
        }
        
        func endTimer() {
            timer.invalidate()
            timerLbl.isHidden = true
            resendBtn.isHidden = false
            countdownSeconds = 30
            resendBtn.isEnabled = true
        }
        
        func timeFormatted(_ totalSeconds: Int) -> String {
            let seconds: Int = totalSeconds % 60
            let minutes: Int = (totalSeconds / 60) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
            
            @objc func updateTimer() {
                countdownSeconds -= 1
                if countdownSeconds <= 0 {
                    // Timer expired, invalidate the timer and enable the button
                    timer?.invalidate()
                    timer = nil
                    resendBtn.isEnabled = true
                }
                updateTimerLabel() // Update the button title
            }
            
            func updateTimerLabel() {
                let title: String
                if countdownSeconds <= 0 {
                    title = "Resend"
                } else {
                    title = String(format: "Resend (%02d)", countdownSeconds)
                }
                resendBtn.setTitle(title, for: .normal)
            }
    
    @IBAction func backBtnHit(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           timerLbl.isHidden = true
           otpTextFields = [otpField1, otpField2, otpField3, otpField4]
           setupOTPTextFields()
           styleOTPTextFields()
           
                  if let phoneNumber = Udata.phoneNumber {
                      numberLbl.text = "Please enter 4-digit verification code sent to \(phoneNumber)"
                  } else {
                      numberLbl.text = "Please enter 4-digit verification code sent to your number" // Default message
                  }
       }
       
       func styleOTPTextFields() {
           for textField in otpTextFields {
               textField.textColor = UIColor.black
               textField.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
               textField.borderStyle = .none
               textField.layer.cornerRadius = 12
               textField.textAlignment = .center
               textField.delegate = self
           }
       }
       
       func setupOTPTextFields() {
           for textField in otpTextFields {
               textField.delegate = self
               textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
           }
       }
       
       @IBAction func resendButtonTapped(_ sender: UIButton) {
          
          }

       
       @IBAction func actionButtonTapped(_ sender: UIButton) {
           let enteredOTP = otpTextFields.compactMap { $0.text }.joined()
           if enteredOTP.isEmpty {
               warningLbl.isHidden = false // Show warning label if OTP is empty
           } else {
               warningLbl.isHidden = true // Hide warning label if OTP is not empty
               // Perform OTP verification logic here
           }
       }
       
       @objc func textFieldDidChange(_ textField: UITextField) {
           textField.textColor = .black // Reset text color to black
           if let text = textField.text, text.count >= 1 {
               // Move to the next text field or resign the keyboard if the last one is reached
               if let index = otpTextFields.firstIndex(of: textField), index < otpTextFields.count - 1 {
                   otpTextFields[index + 1].becomeFirstResponder()
               } else {
                   textField.resignFirstResponder()
               }
           }
       }
   }

   extension OTPVerificationVC: UITextFieldDelegate {
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           let maxLength = 1
           guard let text = textField.text, text.count + string.count - range.length <= maxLength else {
               return false
           }
           return true
       }
   }
