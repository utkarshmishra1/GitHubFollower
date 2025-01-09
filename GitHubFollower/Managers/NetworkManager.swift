//
//  NetworkManager.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 26/12/24.
//
//making it singleTon
import UIKit
class NetworkManager{
//    here shared is singleton
    static let shared           = NetworkManager()
    private let baseURL         = "https://api.github.com/users/"
    let cache                   = NSCache<NSString, UIImage>() // made an Singleton cache
    
//    to use singleton cache we use networkManager.shared.
//    it is single so we use private init
    private init(){}

//page: Int: the page number of followers (useful for paginated API results).
//    This is a completion handler—a closure used to handle the result of the asynchronous operation.
    ///   - [Follower]?: List of followers if successful, or `nil` if failed.
    ///   - String?: An error message if the fetch fails, or `nil` if successful.
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void){
        let endpoint = baseURL + username + "/followers?per_page=100&page=\(page)"
        
//        create a url if it is invalid through an error
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
//        for the error we can use error.localisedDescripsion but we want por own error
        
//        if we get a valid url, URLSession used to fetch data from the provided URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

//            we only move forward if the response is 200 else show error
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidData))
                return
                
            }
//            making sure data is not nil
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
//             Parsing
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                getting array of followers
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
            }
        task.resume()
        }

    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void){
        let endpoint = baseURL + "\(username)"
        
//        create a url if it is invalid through an error
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
//        for the error we can use error.localisedDescripsion but we want por own error
        
//        if we get a valid url, URLSession used to fetch data from the provided URL
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            

//            we only move forward if the response is 200 else show error
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidData))
                return
                
            }
//            making sure data is not nil
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
//             Parsing
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                getting array of followers
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
            }
        task.resume()
        }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
           let cacheKey = NSString(string: urlString)
           
           if let image = cache.object(forKey: cacheKey) {
               completed(image)
               return
           }
           
           guard let url = URL(string: urlString) else {
               completed(nil)
               return
           }
           
           let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
               guard let self = self,
                     error == nil,
                     let response = response as? HTTPURLResponse, response.statusCode == 200,
                     let data = data,
                     let image = UIImage(data: data) else {
                   completed(nil)
                   return
               }
               
               self.cache.setObject(image, forKey: cacheKey)
               completed(image)
           }
           task.resume()
       }
   }
    

    

