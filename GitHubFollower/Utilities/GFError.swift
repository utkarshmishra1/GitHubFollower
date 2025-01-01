//
//  GFError.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 30/12/24.
//

import Foundation
enum GFError: String, Error {
    case invalidUsername        = "Invalid URL"
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
    case invalidResponse        = "Invalid response from the server. Please try again."
    case invalidData            = "Invalid data received from the server. Please try again."
    case unableToFavorite       = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites     = "You've already favorited this user, you must really like them."
}
