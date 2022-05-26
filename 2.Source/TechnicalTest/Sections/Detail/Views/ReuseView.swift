//
//  DynamicView.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation
import UIKit

protocol ReuseViewInput {
    func bindData(text: String, element: Any?)
}

class ReuseView: UIView {
    
    // MARK: IBOutlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    // MARK: - Private helpers
    
    private func setupView() {
        self.loadView()
    }
    
    private func loadView() {
        Bundle.main.loadNibNamed(String(describing: ReuseView.self), owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = text
        return label
    }
    
    private func createItemList(itemList: [Item]) {
        for item in itemList {
            self.stackView.addArrangedSubview(self.createLabel(text: "Name: \(item.name)"))
            if let type = item.type {
                self.stackView.addArrangedSubview(self.createLabel(text: "Type: \(type.rawValue)"))
            }
        }
    }
}

// MARK: - ReuseViewInput

extension ReuseView: ReuseViewInput {
        
    func bindData(text: String, element: Any?) {
        guard let element = element else {
            return
        }

        self.textLabel.text = text
                
        if let comic = element as? Comic {
            self.stackView.addArrangedSubview(self.createLabel(text: "Avaliable: \(comic.available)"))
            self.createItemList(itemList: comic.itemList)
        }
        if let serie = element as? Serie {
            self.stackView.addArrangedSubview(self.createLabel(text: "Avaliable: \(serie.available)"))
            self.createItemList(itemList: serie.itemList)
        }
        if let story = element as? Story {
            self.stackView.addArrangedSubview(self.createLabel(text: "Avaliable: \(story.available)"))
            self.createItemList(itemList: story.itemList)
        }
    }
}
