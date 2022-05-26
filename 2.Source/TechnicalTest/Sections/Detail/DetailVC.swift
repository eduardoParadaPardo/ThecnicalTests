//
//  DetailVC.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 24/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import UIKit

class DetailVC: BaseVC {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var heroImag: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var idTitleLabel: UILabel!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
        // MARK: - Attributtes
    
    var presenter: DetailPresenter?
        
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.localize()
        self.presenter?.viewDidLoad()
    }
    
    private func localize() {
        self.idTitleLabel.text = "ID:"
        self.nameTitleLabel.text = "Name:"
        self.descriptionTitleLabel.text = "Description:"
    }
    
    private func createViewsReusables(title: String, data: Any?) {
        let comicView = ReuseView()
        comicView.bindData(text: title, element: data)
        self.stackView.addArrangedSubview(comicView)
    }
}

// MARK: - DetailPresenterOutput

extension DetailVC: DetailPresenterOutput {
    
    func showSuperHero(with hero: SuperHero) {
        self.idLabel.text = "\(hero.id)"
        self.nameLabel.text = hero.name
        self.descriptionLabel.text = hero.description
        
        ImageCache.shared.downloadImage(url: hero.image) { image in
            DispatchQueue.main.async {
                self.heroImag.image = image
            }
        }
        
        self.createViewsReusables(title: "Comic:", data: hero.comics)
        self.createViewsReusables(title: "Series:", data: hero.serie)
        self.createViewsReusables(title: "Story:", data: hero.story)
    }
    
    func updateLoading(show: Bool) {
        if show {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
    
    func showError(text: String) {
        self.showAlertError(text: text)
    }
}
