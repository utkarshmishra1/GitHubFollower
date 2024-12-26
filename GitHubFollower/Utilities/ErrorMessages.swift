//
//  ErrorMessages.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 26/12/24.
//

import Foundation
enum GFError: String, Error {
    case invalidUsername     = "Invalid URL"
    case unableToComplete    = "Unable to complete your request. Please check your internet connection."
    case invalidResponse     = "Invalid response from the server. Please try again."
    case invalidData         = "Invalid data received from the server. Please try again."
}
