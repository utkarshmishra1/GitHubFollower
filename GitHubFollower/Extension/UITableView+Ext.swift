//
//  UITableView+Ext.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 31/12/24.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
