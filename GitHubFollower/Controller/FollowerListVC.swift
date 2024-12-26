//
//  FollowerListVCViewController.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 25/12/24.
//

import UIKit

class FollowerListVC: UIViewController {
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMesage in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: errorMesage!.rawValue, buttonTile: "OK")
                return
                
            }
            print("Follower.count = \(followers.count)")
            print(followers)
            
        }
            
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

     
    }
   

