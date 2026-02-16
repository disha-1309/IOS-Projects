//
//  DetailCollectionViewCell.swift
//  Real Estate
//
//  Created by Droisys on 24/09/25.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.backgroundColor = .white
        self.clipsToBounds = true
    }
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = .black
                self.detailLabel.textColor = .white
            } else {
                self.backgroundColor = .white
                self.detailLabel.textColor = .systemGray
            }
        }
    }
}
