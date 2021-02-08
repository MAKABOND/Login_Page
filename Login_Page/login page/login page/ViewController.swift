//
//  ViewController.swift
//  login page
//
//  Created by MAKAR4IK BOND on 4.02.21.
//
import UIKit
        // MARK: - Enum errors
enum LoginErrors: Error {
    case invalidEmail
    case invalidPassword
    case emptyFieldEmail
    case emptyFieldPassword
}
        // MARK: - Properties
        var passwordText: String = ""
        var allert: String = ""

class Utils {
    static func getPassword() {
        let passwordCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        passwordText = String((0...7).compactMap{ _ in passwordCharacters.randomElement() })
        print(passwordText)
    }
}

class ViewController: UIViewController {
        // MARK: - Outlets
    @IBOutlet weak var image: UIImageView! {
    didSet {
            self.image.image = UIImage(named: "unreg")
            self.image.layer.borderWidth = 1
            self.image.layer.cornerRadius = 120
            self.image.layer.shadowRadius = 1
        }
    }
    
    @IBOutlet weak var mail: UITextField!{
        didSet {
            self.mail.layer.cornerRadius = 15
            self.mail.placeholder = "Enter your e-mail"
            self.mail.clearButtonMode = .whileEditing
        }
    }
    
    @IBOutlet weak var password: UITextField! {
        didSet {
            self.password.layer.cornerRadius = 15
            self.password.placeholder = "Enter your password"
            self.password.isSecureTextEntry = true
            self.password.clearButtonMode = .whileEditing
        }
    }
    
    @IBOutlet weak var button: UIButton! {
        didSet {
            self.button.backgroundColor = .green
            self.button.layer.cornerRadius = 15
            self.button.layer.borderWidth = 1
            self.button.setTitle("Register", for: UIControl.State.normal)
        }
    }

        // MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utils.getPassword()
        self.view.backgroundColor = .systemGray6
    }
        // MARK: - Action
    @IBAction func pressButton(_ sender: Any) {
            do {
                try login()
            } catch {
                allert = error.localizedDescription
                
                let allertController = UIAlertController (title: "Ошибка",
                                                          message: allert,
                                                          preferredStyle: .alert)
                
                allertController.addAction(UIAlertAction(title: "OK",
                                                         style: .default,
                                                         handler: nil))
                
                self.present(allertController,
                             animated: true,
                             completion: nil)
            }
        }
    
        // MARK: - Methods
    private func login() throws {
            guard let email = self.mail.text else { throw LoginErrors.invalidEmail }
            guard !email.isEmpty else { throw LoginErrors.emptyFieldEmail }
            guard email.contains("@") && email.contains(".") else { throw LoginErrors.invalidEmail }
            guard let UserPassword = self.password.text else { throw LoginErrors.invalidPassword }
            guard !UserPassword.isEmpty else { throw LoginErrors.emptyFieldPassword }
            guard UserPassword == passwordText else { throw LoginErrors.invalidPassword }
            self.image.image = UIImage(named: "reg")
            print("Success autorised")
        }
}

extension LoginErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Неверный формат e-mail!", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Неверный пароль!", comment: "")
        case .emptyFieldEmail:
            return NSLocalizedString("E-mail не введен!", comment: "")
        case .emptyFieldPassword:
            return NSLocalizedString("Пароль не введен!", comment: "")
        }
    }
}


