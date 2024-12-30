//
//  UserInfoVCViewController.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 29/12/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                self.title = user.login
//                self.navigationItem.titleView = UIImageView(image: user.avatarURL)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTile: "OK")

            }
        }
    }
  @objc func dismissVC() {
        dismiss(animated: true)
    }

}
