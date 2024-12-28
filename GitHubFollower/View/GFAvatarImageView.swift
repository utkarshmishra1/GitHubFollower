//
//  GFAvatarImageView.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 26/12/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    let cache            = NetworkManager.shared.cache

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
//     so now before doing caching images download each time like - we go down and then up then again the above images will download again
    func downloadImage(from urlString: String){
        
        let cacheKey = NSString(string: urlString) //cannot use now in swift 6+
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }

            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image  = UIImage(data: data) else { return }
            // any time  we update the UI we do on the main thread
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async {
                self.image = image
            }
 
            
        }
        task.resume()
    }
    
}
