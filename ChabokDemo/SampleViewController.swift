//
//  SampleTableViewController.swift
//  ChabokDemo
//
//  Created by husseinhj on 10/17/21.
//

import UIKit
import ChabokKit

struct Credentials {
    var clientId: String
    var clientSecret: String
}

class SampleViewController: UITableViewController {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var initializeLabel: UILabel!
    @IBOutlet weak var clientIdTextField: UITextField!
    @IBOutlet weak var clientSecretTextField: UITextField!
    
    @IBOutlet weak var attributeKeyTextField: UITextField!
    @IBOutlet weak var attributeValueTextField: UITextField!
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var timezoneTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillInputs()
    }
    
    func fillInputs() {
//        self.initializeLabel.text = "Initialize 🟡"
        
//        clientIdTextField.text = UserDefaults.standard.string(forKey: "cid") ?? ""
//        clientSecretTextField.text = UserDefaults.standard.string(forKey: "sid") ?? ""
        
        self.userIdTextField.text = ""//Chabok.user().userId
        self.birthdayTextField.text = Date().adding(days: -8024).iso8601
        self.timezoneTextField.text = TimeZone.current.abbreviation() ?? ""
    }
    
    func storeCredentials() -> Credentials {
        let clientId = clientIdTextField.text ?? ""
        let clientSecret = clientSecretTextField.text ?? ""
        
        UserDefaults.standard.set(clientId, forKey: "cid")
        UserDefaults.standard.set(clientSecret, forKey: "sid")
        
        UserDefaults.standard.synchronize()
        return Credentials.init(clientId: clientId, clientSecret: clientSecret)
    }
    
    func showInitState(state: Bool) {
//        if state {
//            self.initializeLabel.text = "Initialize 🟢"
//        } else {
//            self.initializeLabel.text = "Initialize 🔴"
//        }
    }
    
    @IBAction func loginClicked(_ sender: Any) {
        if let userId = self.userIdTextField.text {
            Chabok.user().login(userId: userId) {
                (success:Bool,message:String) in
                if(success) {
                }
            }
            return
        }
        showAlert(withTitle: "UserId is null", withMessage: "Please provide a userId")
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        Chabok.user().logout(){
            (success:Bool,message:String) in
            if(success) {
            }
        }
    }
    
    @IBAction func sendAttributeClicked(_ sender: Any) {
        let key = self.attributeKeyTextField.text ?? "City"
        let value = self.attributeValueTextField.text ?? "Karaj"
        Chabok.user().setAttribute(key: key,value:value)
    }
    
    
    @IBAction func sendEventClicked(_ sender: Any) {
        let name = self.eventNameTextField.text ?? "Unknown"
        
        Chabok.analytics().sendEvent(id: name, body: [:]) {
            (success:Bool,message:String) in
            if(!success) {
            }
        }
    }
    
    @IBAction func searchEventClicked(_ sender: Any) {
        let name = "123456789012345678901234"
        let payload: [String: Any] = [
            "keywords": ["banana", "cheese", "apple"]
        ]
        
        Chabok.analytics().sendEvent(id: name, body: payload) {
            (success:Bool,message:String) in
            if(success) {
            } else {
            }
        }
    }
    @IBAction func reviewEventClicked(_ sender: Any) {
        let name = "Review"
        let payload: [String: Any] = [
            "orderId": UUID.init().uuidString,
            "order": ["banana", "cheese", "apple"]
        ]
        
        Chabok.analytics().sendEvent(id: name, body: payload)
    }
    @IBAction func addToCartEventClicked(_ sender: Any) {
        let name = "AddToCart"
        let payload: [String: Any] = [
            "revenue": 180000,
            "currency": "RIAL",
            "orderId": UUID.init().uuidString,
            "order": ["banana"]
        ]
        
        Chabok.analytics().sendEvent(id: name, body: payload)
    }
    
    @IBAction func purchaseEventClicked(_ sender: Any) {
        let name = "Purchase"
        let payload: [String: Any] = [
            "revenue": 250000,
            "currency": "RIAL",
            "orderId": UUID.init().uuidString,
            "order": ["banana", "cheese", "apple"]
        ]
        
        Chabok.analytics().sendEvent(id: name, body: payload)
    }
    @IBAction func updateProfileClicked(_ sender: Any) {
        let profile: Profile.Builder = Profile.Builder()
        
        if let firstname = firstnameTextField.text {
            profile.name(firstname)
        }
        
        if let lastname = lastnameTextField.text {
            profile.family(lastname)
        }
        
        if let email = emailTextField.text {
            profile.email(email)
        }
        
        if let phone = phoneTextField.text {
            profile.mobile(phone)
        }
        
        if let birthday = birthdayTextField.text {
            profile.birthDate(birthday)
        }
        
        if let gender = genderTextField.text {
            let state = gender.lowercased() == "male" || gender.lowercased() == "1"
            profile.gender(state ? Gender.MALE : Gender.FEMALE)
        }
        
        if let timezone = timezoneTextField.text {
            profile.timeZone(timezone)
        }
        
        Chabok.user().setProfile(profile: profile.build())
    }
    @IBAction func sampleProfileClicked(_ sender: Any) {
        let profile:Profile = Profile.Builder()
            .email("hoss@gmail.com")
            .mobile("09100360500")
            .name("Hossein")
            .family("Shooshtari")
            .timeZone("210")
            .birthDate("1992-02-10")
            .gender(Gender.MALE)
            .build()
        Chabok.user().setProfile(profile: profile)
    }
}


extension  UIViewController {
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in })
//        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in})
        
        alert.addAction(ok)
//        alert.addAction(cancel)
        
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}


extension Date {
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    func adding(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: self)!
    }
    var last7days: [Int] {
        return (1...7).map {
            adding(days: -$0).day
        }
    }
    func near(days: Int) -> [Int] {
        return days == 0 ? [day] : (1...abs(days)).map {
            adding(days: $0 * (days < 0 ? -1 : 1) ).day
        }
    }
    var iso8601: String {
        if #available(OSX 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
            return ISO8601DateFormatter.string(from: self, timeZone: TimeZone.current, formatOptions: .withInternetDateTime)
        } else {
            var buffer = [CChar](repeating: 0, count: 25)
            var time = time_t(self.timeIntervalSince1970)
            strftime_l(&buffer, buffer.count, "%FT%T%z", localtime(&time), nil)
            return String(cString: buffer)
        }
    }
}
