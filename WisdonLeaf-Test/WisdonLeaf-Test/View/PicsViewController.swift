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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosTableView.rowHeight = UITableView.automaticDimension
        getPhotosInformation()
    }
    
    
    // calls remote url to fetch the photos information and loads the tableView
    func getPhotosInformation() {
        Service.shared.fetchPhotos(){ (response, error) in
            if error == nil {
                if let photos = response {
                    print(photos)
                    DispatchQueue.main.async {
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
