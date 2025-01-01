//
//  GFTextField.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 22/12/24.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius              = 10
        layer.borderWidth               = 2
        layer.borderColor               = UIColor.systemGray4.cgColor
        
        textColor                       = .label
        tintColor                       = .label
        textAlignment                   = .center
        font                            = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth       = true
        minimumFontSize                 = 12
        
        backgroundColor                 = .tertiarySystemBackground
        autocorrectionType              = .no
//        keyboardType = .asciiCapable  // If you want any modification of the keyboard you want
        returnKeyType                   = .go
        clearButtonMode                 = .whileEditing
        placeholder                     = "Enter a username"
    }
    
}
