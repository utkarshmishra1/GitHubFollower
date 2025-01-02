//
//  Date+Ext.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 31/12/24.
//


import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
