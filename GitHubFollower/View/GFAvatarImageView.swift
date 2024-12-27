//
//  GFAvatarImageView.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 26/12/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super .init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true// ye nhi krenge to image ki sharp corner rahegi baaki ki nhi
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
