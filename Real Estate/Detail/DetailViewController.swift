//
//  DetailViewController.swift
//  Real Estate
//
//  Created by Droisys on 24/09/25.
//

import UIKit

class DetailViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    private var forRentButton: UIButton!
    private var forSaleButton: UIButton!
    private var containerView: UIView!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    
    @IBOutlet weak var priceview1: UIView!
    @IBOutlet weak var priceView2: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var properties: [RealEstateName] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPropertiesData()
        styleRoomOptionViews()
        //priceStyle()
        self.title = "Filter Property"
        
        // Customize UINavigationBar  appearance
        if let navigationBar = navigationController?.navigationBar {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            
            // Customize Navigation bar  title
            let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            appearance.titleTextAttributes = titleAttributes
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }
        
        
        
        
        self.view.backgroundColor = .white
        
        // Use the helper function for the back button
        let backBarButtonItem = createCircularBarButtonItem(imageName: "chevron.left", action: #selector(handleBackButton))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        // Use the same helper function for the reload button
        let reloadBarButtonItem = createCircularBarButtonItem(imageName: "arrow.clockwise", action: #selector(handleReloadButton))
        self.navigationItem.rightBarButtonItem = reloadBarButtonItem
        
        setupPropertyTypeToggle()
        
        // Set an initial selection
        updateSelection(selectedButton: forSaleButton, unselectedButton: forRentButton)
    }
    
    
    func styleRoomOptionViews() {
        // Collect all four views into an array for easy iteration
        let roomViews: [UIView?] = [
            view1,view2,view3,view4,view5,view6,view7,view8,priceview1,priceView2
        ]
        
        let lightGrayColor = UIColor.lightGray.cgColor
        let borderWidth: CGFloat = 1.0
        
        for roomView in roomViews {
            guard let view = roomView else { continue }
            
            let cornerRadius = view.frame.height / 2.0
            
            // 2. Convert to Circle Shape
            view.layer.cornerRadius = cornerRadius
            
            // 3. Set Border Color to Light Gray
            view.layer.borderColor = lightGrayColor
            
            // 4. Set Border Width
            view.layer.borderWidth = borderWidth
            
            // Ensures clipping to bounds is on
            view.clipsToBounds = true
            
            
        }
    }
    
    func priceStyle() {
        // Collect all four views into an array for easy iteration
        let roomViews: [UIView?] = [
            priceview1,priceView2
        ]
        
        let lightGrayColor = UIColor.lightGray.cgColor
        let borderWidth: CGFloat = 1.0
        
        for roomView in roomViews {
            guard let view = roomView else { continue }
            
            let cornerRadius = view.frame.height / 2.0
            
            // 2. Convert to Circle Shape
            view.layer.cornerRadius = cornerRadius
            
            // 3. Set Border Color to Light Gray
            view.layer.borderColor = lightGrayColor
            
            // 4. Set Border Width
            view.layer.borderWidth = borderWidth
            
            // Ensures clipping to bounds is on
            view.clipsToBounds = true
            
            
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
    
    
    func setupPropertyTypeToggle() {
        // Create the main container view
        containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 25 // Adjust for desired oval shape
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        containerView.clipsToBounds = true
        
        // Create the two buttons
        forRentButton = UIButton(type: .system)
        forRentButton.translatesAutoresizingMaskIntoConstraints = false
        forRentButton.setTitle("For Rent", for: .normal)
        forRentButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        forRentButton.addTarget(self, action: #selector(forRentTapped), for: .touchUpInside)
        
        forSaleButton = UIButton(type: .system)
        forSaleButton.translatesAutoresizingMaskIntoConstraints = false
        forSaleButton.setTitle("For Sale", for: .normal)
        forSaleButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        forSaleButton.addTarget(self, action: #selector(forSaleTapped), for: .touchUpInside)
        
        // Add buttons to the container view
        containerView.addSubview(forRentButton)
        containerView.addSubview(forSaleButton)
        
        // Add the container view to the main view
        self.view.addSubview(containerView)
        
        // Setup Auto Layout constraints
        NSLayoutConstraint.activate([
            // Container View Constraints
            containerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            // For Rent Button Constraints
            forRentButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            forRentButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            forRentButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            forRentButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            
            // For Sale Button Constraints
            forSaleButton.topAnchor.constraint(equalTo: containerView.topAnchor),
            forSaleButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            forSaleButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            forSaleButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    // Action methods for the new buttons
    @objc func forRentTapped() {
        print("For Rent tapped")
        updateSelection(selectedButton: forRentButton, unselectedButton: forSaleButton)
    }
    
    @objc func forSaleTapped() {
        print("For Sale tapped")
        updateSelection(selectedButton: forSaleButton, unselectedButton: forRentButton)
    }
    
    // New helper function to handle UI updates
    private func updateSelection(selectedButton: UIButton, unselectedButton: UIButton) {
        // Set the appearance for the selected button
        selectedButton.backgroundColor = .black
        selectedButton.setTitleColor(.white, for: .normal)
        
        // Set the appearance for the unselected button
        unselectedButton.backgroundColor = .clear
        unselectedButton.setTitleColor(.black, for: .normal)
    }
    
    // This is the helper function
    private func createCircularBarButtonItem(imageName: String, action: Selector) -> UIBarButtonItem {
        // Create a circular container view
        let buttonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        buttonContainer.backgroundColor = .clear
        buttonContainer.layer.cornerRadius = 20
        buttonContainer.clipsToBounds = true
        buttonContainer.layer.borderWidth = 1.0
        buttonContainer.layer.borderColor = UIColor.systemGray4.cgColor
        
        // Create the UIButton
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = .black
        button.frame = buttonContainer.bounds
        button.addTarget(self, action: action, for: .touchUpInside)
        
        // Add the button to the container
        buttonContainer.addSubview(button)
        
        // Return the UIBarButtonItem with the custom view
        return UIBarButtonItem(customView: buttonContainer)
    }
    
    //action method for back button
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
        print("back button tapped")
    }
    
    @objc func handleReloadButton() {
        self.navigationController?.popViewController(animated: true)
        print("reload button tapped")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DetailCollectionViewCell
        let property = properties[indexPath.row]
        cell.detailLabel.text = property.name
        return cell
    }
}
