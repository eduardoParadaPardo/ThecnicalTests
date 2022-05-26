//
//  AccountCell.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

protocol SuperHeroCellInput {
    func bindData(from data: SuperHero)
}

class SuperHeroCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    
    // MARK: - Public Method

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - SuperHeroCellInput

extension SuperHeroCell: SuperHeroCellInput {
    
    func bindData(from data: SuperHero) {
        self.idLabel.text = "\(data.id)"
        self.nameLabel.text = data.name
        
        ImageCache.shared.downloadImage(url: data.image) { image in
            DispatchQueue.main.async {
                self.heroImage.image = image
            }
        }
    }
}
