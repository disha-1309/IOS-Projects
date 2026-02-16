//
//  HomeViewController.swift
//  Real Estate
//  Created by Droisys on 19/09/25.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var seceondCollectionView: UICollectionView!
    @IBOutlet weak var thirdCollectionView: UICollectionView!
    
    
    var properties: [RealEstateName] = []
    var productDetails: [Product] = []
    var detailImage:[DetailImage] = []
    private var searchTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpNavigationBar()
        loadPropertiesData()
        //loadPropertiDetails()
        loadImageDetails()
        runProductDemo()
        //addNewProduct()
        
        // NAVIGATION BAR APPEARANCE FIX
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white // Set Background white
            
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
            
            // Set View background white
            self.view.backgroundColor = .white
        }
    }
    
    
    func loadPropertiesData() {
        
        if let filePath = Bundle.main.url(forResource: "Category", withExtension: "json") {
            
            do {
                let jsonData = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                self.properties = try decoder.decode([RealEstateName].self, from: jsonData)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            } catch {
                print("Error loading or decoding JSON: \(error)")
            }
        }
        
        
    }
    
    //    func loadPropertiDetails() {
    //        
    //        if let filePath = Bundle.main.url(forResource: "PropertiesDetails", withExtension: "json") {
    //            
    //            do {
    //                let jsonData = try Data(contentsOf: filePath)
    //                let decoder = JSONDecoder()
    //                self.propertyDetails = try decoder.decode([PropertyDetail].self, from: jsonData)
    //                DispatchQueue.main.async {
    //                    self.seceondCollectionView.reloadData()
    //                }
    //                
    //            } catch {
    //                print("Error loading or decoding JSON: \(error)")
    //            }
    //        }
    //        
    //        
    //    }
    func runProductDemo() {
        let apiService = ProductAPIService()
        
        Task {
            do {
                // data fetching
                let products = try await apiService.fetchProducts()
                
                // update product detail arry
                self.productDetails = products
                
                //  UI update
                DispatchQueue.main.async {
                    self.seceondCollectionView.reloadData()
                }
            } catch NetworkError.invalidURL {
                print(" Invalid URL")
            } catch NetworkError.noData {
                print(" No data received or bad response")
            } catch NetworkError.decodingError(let error) {
                print(" Failed to decode JSON: \(error.localizedDescription)")
            } catch {
                print(" Unexpected error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func loadImageDetails(){
        if let filePath = Bundle.main.url(forResource: "DetailImage", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: filePath)
                let decoder = JSONDecoder()
                self.detailImage = try decoder.decode([DetailImage].self,from: jsonData)
                DispatchQueue.main.async {
                    self.thirdCollectionView.reloadData()
                }
            } catch {
                print("Error loading or decoding JSON: \(error)")
            }
        }
    }
    
    
    func setUpNavigationBar() {
        // Get the actual navigation bar width instead of screen width
        let navBarWidth = navigationController?.navigationBar.frame.width ?? UIScreen.main.bounds.width
        let rightButtonWidth: CGFloat = 100 // actual right button space
        let margins: CGFloat = 5 // minimal margins
        
        // Calculate available width
        let availableWidth = navBarWidth - rightButtonWidth - margins
        
        // Create a container view that uses calculated width
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 0, width: availableWidth, height: 24)
        containerView.backgroundColor = .clear
        
        // Create a custom text field instead of search bar
        let searchTextField = UITextField()
        searchTextField.placeholder = "Search"
        searchTextField.backgroundColor = .white
        searchTextField.textColor = .black
        searchTextField.tintColor = .black
        searchTextField.font = UIFont.systemFont(ofSize: 16)
        
        // Style the text field
        searchTextField.layer.cornerRadius = 22 // Half of height (44/2)
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.systemGray4.cgColor
        searchTextField.clipsToBounds = true
        
        // Add search icon
        let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImageView.tintColor = .systemGray
        searchImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 44))
        searchImageView.center = leftView.center
        leftView.addSubview(searchImageView)
        
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = .always
        
        // Add text field to container - full width
        containerView.addSubview(searchTextField)
        searchTextField.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: 44)
        
        // Set delegate
        searchTextField.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        // Set the container as navigation title view
        navigationItem.titleView = containerView
        
        // Create a circular container view for the button
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        buttonContainer.backgroundColor = .clear
        buttonContainer.layer.cornerRadius = 20
        buttonContainer.clipsToBounds = true
        buttonContainer.layer.borderWidth = 1.0
        buttonContainer.layer.borderColor = UIColor.systemGray5.cgColor
        
        // Create the UIButton with the desired image and color
        let filterButton = UIButton(type: .system)
        filterButton.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        filterButton.tintColor = .black
        filterButton.frame = buttonContainer.bounds
        filterButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        
        // Add the button to the container view
        buttonContainer.addSubview(filterButton)
        
        // Set the container view as the right bar button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonContainer)
        
        // Customize the navigation bar appearance
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .white
    }
    
    //  using viewDidLayoutSubviews for orientation handling
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Small delay to ensure navigation bar has updated its frame
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.updateSearchBarWidth()
        }
    }
    
    //  this method to handle orientation changes
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            // Update search bar during rotation
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.updateSearchBarWidth()
            }
        })
    }
    
    // Helper method to update search bar width
    func updateSearchBarWidth() {
        guard let titleView = navigationItem.titleView,
              let navigationBar = navigationController?.navigationBar else { return }
        
        // Get the actual navigation bar width (more accurate than screen width)
        let navBarWidth = navigationBar.frame.width
        let rightButtonWidth: CGFloat = 100
        let margins: CGFloat = 5
        
        // Calculate available width
        let availableWidth = navBarWidth - rightButtonWidth - margins
        
        // Ensure minimum width
        let finalWidth = max(availableWidth, 200)
        
        // Update container frame
        titleView.frame = CGRect(x: 0, y: 0, width: finalWidth, height: 44)
        
        // Update search text field frame if it exists
        if let searchTextField = titleView.subviews.first as? UITextField {
            searchTextField.frame = CGRect(x: 0, y: 0, width: finalWidth, height: 44)
        }
        
        titleView.setNeedsLayout()
        titleView.layoutIfNeeded()
    }
    
    //  method to handle search text changes
    @objc func searchTextChanged(_ textField: UITextField) {
        print("Search text: \(textField.text ?? "")")
    }
    
    @objc func rightButtonTapped() {
        print("Right button tapped!")
        logoutUser()
    }
    func logoutUser() {
        //  Remove user from UserDefaults
        UserDefaults.standard.removeObject(forKey: "currentUserEmail")
        UserDefaults.standard.synchronize()
        
        //  Redirect to Login screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC")
        
        //  Reset root view controller so user can't go back to Home
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = windowScene.delegate as? SceneDelegate {
            
            let navController = UINavigationController(rootViewController: loginVC)
            delegate.window?.rootViewController = navController
            delegate.window?.makeKeyAndVisible()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionView {
            return properties.count
        } else if collectionView == self.seceondCollectionView {
            return productDetails.count
        } else if collectionView == self.thirdCollectionView {
            return detailImage.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryViewCell
            let property = properties[indexPath.row]
            cell.dataLabel.text = property.name
            return cell
        } else if collectionView == self.seceondCollectionView {
            let cell = seceondCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PropertyDetailCell
            let productDetail = productDetails[indexPath.row]
            cell.priceLabel.text = String(format: "$ %.2f",productDetail.price)
            cell.addressLabel.text = productDetail.title
            if let url = URL(string: productDetail.image) {
                
                cell.imgData.image = nil
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            // Ensure the cell at this indexPath is still the same before setting the image
                            if let currentCell = collectionView.cellForItem(at: indexPath) as? PropertyDetailCell {
                                currentCell.imgData.image = image
                            }
                        }
                    }
                }.resume()
            }
            return cell
        }
        
        else if collectionView == self.thirdCollectionView {
            let cell = thirdCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailImageViewCell
            let detailImage  = detailImage[indexPath.row]
            cell.detailLabel.text = detailImage.name
            if let url = URL(string:detailImage.image) {
                
                cell.detailImage.image = nil
                
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            // Ensure the cell at this indexPath is still the same before setting the image
                            if let currentCell = collectionView.cellForItem(at: indexPath) as? DetailImageViewCell {
                                currentCell.detailImage.image = image
                            }
                        }
                    }
                }.resume()
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Check if the tap is on the second collection view
        if collectionView == self.seceondCollectionView {
            
            // Instantiate the DetailViewController from the storyboard
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let detailVC = storyboard.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController {
                self.navigationController?.pushViewController(detailVC, animated: true)
                print("Pushed to DetailViewController")
            }
        }
    }
}

