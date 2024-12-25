//
//  FollowerListVCViewController.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 25/12/24.
//

import UIKit

class FollowerListVC: UIViewController {
    var username: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true

     
    }
    

}
