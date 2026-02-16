//
//  CategoryViewCell.swift
//  Real Estate
//
//  Created by Droisys on 19/09/25.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the corner radius to half of the cell's height
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor =  .white
        self.clipsToBounds = true
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = .accent
                self.dataLabel.textColor = .white
            } else {
                self.backgroundColor = .white
                self.dataLabel.textColor = .lightGray
            }
        }
    }
}
