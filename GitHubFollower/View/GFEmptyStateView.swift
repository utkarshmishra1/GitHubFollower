//
//  GFEmptyStateView.swift
//  GitHubFollower
// 
//  Created by utkarsh mishra on 29/12/24.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text = message
        configureMessageLabel()
        configureLogoImageView()
    }
    
    private func configureMessageLabel() {
            messageLabel.numberOfLines = 3
            messageLabel.textColor = .secondaryLabel
            
            let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -50 : -150
            
            NSLayoutConstraint.activate([
                messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant),
                messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
                messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
                messageLabel.heightAnchor.constraint(equalToConstant: 200)
            ])
        }
        
        
        private func configureLogoImageView() {
            logoImageView.image = Images.emptyStateLogo
            logoImageView.translatesAutoresizingMaskIntoConstraints = false
            
            let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
            
            NSLayoutConstraint.activate([
                logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
                logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
                logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
                logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
            ])
        }
}
