//
//  FollowerListVCViewController.swift
//  GitHubFollower
//
//  Created by utkarsh mishra on 25/12/24.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section{
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>! // it should be hashable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
       
        
        
            
        }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        
      
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout{
        let width                       = view.frame.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers(){
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result{
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTile: "OK")
            
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

    func updateData() {
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

     
    }
   

