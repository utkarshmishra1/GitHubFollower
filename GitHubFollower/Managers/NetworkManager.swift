//
//  NetworkManager.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 26/12/24.
//
//making it singleTon
import Foundation
class NetworkManager{
//    here shared is singleton
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
//    it is single so we use private init
    private init(){}
    
    
//page: Int: the page number of followers (useful for paginated API results).
//    This is a completion handler—a closure used to handle the result of the asynchronous operation.
    ///   - [Follower]?: List of followers if successful, or `nil` if failed.
    ///   - String?: An error message if the fetch fails, or `nil` if successful.
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessages?) -> Void){
        let endpoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        
//        create a url if it is invalid through an error
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUsername)
            return
        }
        
//        for the error we can use error.localisedDescripsion but we want por own error
        
//        if we get a valid url, URLSession used to fetch data from the provided URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, .unableToComplete)
                return
            }
            

//            we only move forward if the response is 200 else show error
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
                
            }
//            making sure data is not nil
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
//             Parsing
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                getting array of followers
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, .invalidData)
            }
            }
        task.resume()
        }
    }
    

