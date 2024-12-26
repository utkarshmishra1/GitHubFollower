//
//  UIViewController+Ext.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 26/12/24.
//
// now call system alert on every view controller, we are making this so that every view have this behaviour instead of subclass where some have only this behaviour
import UIKit
// in any view controller just call this function it will show alert
extension UIViewController {
   func presentGFAlertOnMainThread(title: String?, message: String?, buttonTile: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTile)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
        
    }
}
