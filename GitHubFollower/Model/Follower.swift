//
//  Follower.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 26/12/24.
//

import Foundation
// by using codable the data we are writing like "login" it should be same that is in JSON. and also Codable also convert the snake casing to camel casing automatically so remmeber this
// let decoder = JSONDecoder()
// decoder.keyDecodingStrategy = .convertFromSnakeCase
struct Follower: Codable, Hashable {
    
    let login:      String
    let avatarUrl:  String
}
//struct Follower: Codable, Hashable {
//var login: String var avatarUrl: String
//func hash(into hasher: inout Hasher) {
//hasher.combine (login)
//}
