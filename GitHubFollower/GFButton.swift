//
//  GFButton.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 22/12/24.
//

import UIKit

class GFButton: UIButton {
//     basically hm define kr rhe kaisa hoga button to initialise krna hoga
    override init(frame: CGRect) {
        super.init(frame: frame) // basically hm sari properties default button ki le rhe h then we will customise it
        
//        custom code(it inherits the parent's feature
        configure()
        
    }
    
    
//     to hme 2 baar init krne bol rha, ye wala init isliye krne bol rha(jb hm is button ko init kre storyboard me pr h to kr hi nhi rhe) to delete krdo
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
//     now we don't want that each button have same colour so we --
    init(backgroundColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor // as we are passing our own custom colour
        self.setTitle(title, for: .normal) // we have different states of button but we usualy use normal
        configure()
        
    }
    
    
//    private ka mtlb ki ye sirf is class me hi kam krega(only be called in this class)
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline) //Dynamic fonts
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    

}
