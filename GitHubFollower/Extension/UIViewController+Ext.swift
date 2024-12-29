//
//  UIViewController+Ext.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 26/12/24.
//
// now call system alert on every view controller, we are making this so that every view have this behaviour instead of subclass where some have only this behaviour
import UIKit
// in any view controller just call this function it will show alert

fileprivate var containerView: UIView! // this make it a global variable which can be used in any any function

extension UIViewController {
   func presentGFAlertOnMainThread(title: String?, message: String?, buttonTile: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTile)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
        
    }
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha           = 0
        
        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8}
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
//        activityIndicator.center = containerView.center
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    
        
    }
//     dismissing view from background thread
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView){
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
        
        
    }
}
