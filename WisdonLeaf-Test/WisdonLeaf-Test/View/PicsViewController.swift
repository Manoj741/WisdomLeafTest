//
//  ViewController.swift
//  WisdonLeaf-Test
//
//  Created by manoj kumar on 11/08/20.
//  Copyright © 2020 Manoj Kumar M. All rights reserved.
//

import UIKit

class PicsViewController: UIViewController {
    
    @IBOutlet weak var photosTableView: UITableView!
    
    var fetchedPhotos: [Photo] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupRefreshControl()
        getPhotosInformation()
    }
    
    // sets up the refresh control things
    func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = .none
        refreshControl.addTarget(self, action: #selector(onClickRefresh(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh...", attributes: nil)
        self.photosTableView.addSubview(refreshControl)
    }
    
    // calls remote url to fetch the photos information and loads the tableView
    func getPhotosInformation() {
        LoadingView.shared.showOverlay(view: self.view)
        Service.shared.fetchPhotos(){ (response, error) in
            if error == nil {
                if let photos = response {
                    print(photos)
                    DispatchQueue.main.async {
                        LoadingView.shared.hideOverlayView()
                        self.refreshControl.endRefreshing()
                        self.fetchedPhotos = photos
                        self.photosTableView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert("Error", message: error?.localizedDescription ?? "Error fetching data")
                }
            }
        }
    }
    
    @IBAction func onClickRefresh(_ sender: Any) {
        imageCache.removeAllObjects()  // Remove image data from cache when refresh
        photosTableView.setContentOffset(CGPoint.zero, animated: true)
        getPhotosInformation()
    }
    
}

extension PicsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedPhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let photoCell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell {
            photoCell.configureCell(with: self.fetchedPhotos[indexPath.row])
            cell = photoCell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPhoto = fetchedPhotos[indexPath.row]
        showAlert(selectedPhoto.author, message: selectedPhoto.download_url)
    }
    
}
