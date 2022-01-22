//
//  ViewController.swift
//  ChabokDemo
//
//  Created by Hossein Shooshtari on 6/18/21.
//

import UIKit
import ChabokKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var setAttributeBtn: UIButton!
    @IBOutlet weak var setEventBtn: UIButton!
    @IBOutlet weak var setProfileBtn: UIButton!
    @IBOutlet weak var setLocationBtn: UIButton!
    
    @IBOutlet weak var loginKeyTextField: UITextField!
    @IBOutlet weak var loginValueTextField: UITextField!
    @IBOutlet weak var attrKeyTextField: UITextField!
    @IBOutlet weak var attrValueTextField: UITextField!
    @IBOutlet weak var eventKeyTextField: UITextField!
    @IBOutlet weak var eventValueTextField: UITextField!
    @IBOutlet weak var profileNameTextField: UITextField!
    @IBOutlet weak var profileFamilyTextField: UITextField!
    @IBOutlet weak var profileEmailTextField: UITextField!
    @IBOutlet weak var profileMobileTextField: UITextField!
    @IBOutlet weak var updateLocationLatTextField: UITextField!
    @IBOutlet weak var updateLocationLngTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.addTarget(self, action: #selector(loginClick(_:)), for: .touchUpInside)
        setAttributeBtn.addTarget(self, action: #selector(setAttributeClick(_:)), for: .touchUpInside)
        setEventBtn.addTarget(self, action: #selector(setEventClick(_:)), for: .touchUpInside)
        setProfileBtn.addTarget(self, action: #selector(setProfileClick(_:)), for: .touchUpInside)
        setLocationBtn.addTarget(self, action: #selector(setLocationClick(_:)), for: .touchUpInside)
    }

    @IBAction func loginClick(_ sender: UIButton) {
        Chabok.user().login(userId: loginKeyTextField.text ?? "")
    }
    
    @IBAction func setAttributeClick(_ sender: UIButton) {
        let dic:Dictionary<String,Any> = [attrKeyTextField.text ?? "":attrValueTextField.text ?? ""]
        Chabok.user().setAttribute(key: "City",value:"Karaj")
    }
    
    @IBAction func setEventClick(_ sender: UIButton) {
        let dic:Dictionary<String,Any> = [eventKeyTextField.text ?? "":eventValueTextField.text ?? ""]
//        Chabok.analytics().sendEvent(eventId: "123456789012345678901234", body: dic)
    }
    
    @IBAction func setProfileClick(_ sender: UIButton) {
        let profile:Profile = Profile.Builder()
            .email(profileEmailTextField.text ?? "")
            .mobile(profileMobileTextField.text ?? "")
            .name(profileNameTextField.text ?? "")
            .family(profileFamilyTextField.text ?? "")
            .gender(Gender.MALE)
            .build()
        Chabok.user().setProfile(profile: profile)
    }
    
    @IBAction func setLocationClick(_ sender: UIButton) {
        Chabok.user().setLocation(latitude: Double(updateLocationLatTextField.text ?? "1.0") ?? 1.0 , longitude: Double(updateLocationLngTextField.text ?? "1.0") ?? 1.0)
    }
    
    @IBAction func toastClick(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        UIView.animate(withDuration: 4.0, animations: {
            toastLabel.alpha = 0.0
        })
    }
}
