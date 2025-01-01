//
//  FollowerListVCViewController.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 25/12/24.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers: Bool = true
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>! // it should be hashable
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
        
    }
    
    func configureSearchController(){
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    
    //     network call
    //    Use guard when you need to ensure conditions are met before proceeding and want to exit early if they're not.
    //    Use if for simple checks, especially when no unwrapping or binding is involved.
    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
//            #warning("Call Dismiss")
            
            guard let self = self else { return } // using this we don't need to add ? to the self
            self.dismissLoadingView()
            
            switch result{
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers) // here network call has strong reference to our followerListVC- so we do self weak
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go ahead and follow them!"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                    
                }
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "OK")
                
            }
        }
    }
    
    //     so basically ye function abhi ka snap lega aur baad ka lega aur dono ko animatedly dikhaayega
    //    iska use: Collection view data ko easy aur smoothly update karne ke liye hota hai.
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>( collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            // Dequeue reusable cell
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FollowerCell.reuseID,
                for: indexPath
            ) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        // Create a new snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        // Append section
        snapshot.appendSections([.main])
        // Append items (followers)
        snapshot.appendItems(followers)
        // Apply the snapshot to the data source on the main thread
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped() {
            showLoadingView()
            
            NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
                guard let self = self else { return }
                self.dismissLoadingView()
                
                switch result {
                case .success(let user):
                    self.addUserToFavorites(user: user)
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    
    func addUserToFavorites(user: User) {
           let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
           
           PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
               guard let self = self else { return }
               
               guard let error = error else {
                   self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user 🚀", buttonTitle: "Hooray!")
                   return
               }
               
               self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
           }
       }
   }
    
    
    
extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY             = scrollView.contentOffset.y
        let contentHeight       = scrollView.contentSize.height
        let frameHeight         = scrollView.frame.size.height
            
        if offsetY > contentHeight - frameHeight {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
            }

        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.delegate = self
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
        
    }
    }
    

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListVC: FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followers for that user
        self.username = username
                title = username
                page = 1
                
                followers.removeAll()
                filteredFollowers.removeAll()
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                getFollowers(username: username, page: page)
    }
}
