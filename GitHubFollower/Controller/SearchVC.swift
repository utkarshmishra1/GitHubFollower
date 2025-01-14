//
//  SearchVC.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 22/12/24.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView           = UIImageView()
    let usernameTextField       = GFTextField()
    let callToActionButton      = GFButton(backgroundColor: .systemGreen, title: " Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool{
        return !usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoIageView()
        configureTextField()
        configureCallttoActionButton()
        createDismissKeyboardGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true) // so that at next screen it will not appear
      
    }
    
    func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing)) // endediting - causes the view to resign the first responder status
        view.addGestureRecognizer(tap)
        
    }
//    jb bbi #selector me use ho function to @Objc lgana pdta func me
    @objc func pushFollowerListVC() {
            
            guard isUsernameEntered else {
                presentGFAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know who to look for 😊", buttonTitle: "Ok")
                return
            }
            
            usernameTextField.resignFirstResponder()
            
            let followerListVC = FollowerListVC(username: usernameTextField.text!)
            navigationController?.pushViewController(followerListVC, animated: true)
        }
    
    func configureLogoIageView() {
        logoImageView.image = Images.ghLogo
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self// self is searchVC
       
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        usernameTextField.placeholder = "Username"
        
    }
    
    func configureCallttoActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside) // now whenever we tab on button this will that function will call
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
}

//for organisation and performance
extension SearchVC: UITextFieldDelegate {
//    we need to tell it why we are using it(for what) to iske liye ye delegate jaha lgana h us function me likhna hoga
//    to yaha jaise hm bta rhe ki kya ho jb hm return tap kre searchview me aur ye ye function call krdega
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}

