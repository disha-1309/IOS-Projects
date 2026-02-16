//
//  ViewController.swift
//  Lazy Loading
//
//  Created by Droisys on 08/08/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos: [Photo] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            collectionView.delegate = self
            collectionView.dataSource = self
            
           fetchPhotos()
        }
        
        func fetchPhotos() {
                guard let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=50") else { return }
                
                URLSession.shared.dataTask(with: url) { data, _, error in
                    
                    if let error = error {
                                    print("API Error:", error)
                                    return
                    }
                    
                    
                    
                    if let data = data {
                                    do {
                                        self.photos = try JSONDecoder().decode([Photo].self, from: data)
                                        DispatchQueue.main.async {
                                            self.collectionView.reloadData()
                                        }
                                    } catch {
                                        print("Decoding Error:", error)
                                    }
                                }
                            }.resume()
                        }

    }

    extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return photos.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
                        return UICollectionViewCell()
                    }
                    
                    let photo = photos[indexPath.row]
                    cell.titleLabel.text = photo.author
                    
            if let url = URL(string: photo.download_url) {
                cell.imageView.loadImage(from: url)
            }
            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: 150, height: 150)
        }
        
        
        
    }


