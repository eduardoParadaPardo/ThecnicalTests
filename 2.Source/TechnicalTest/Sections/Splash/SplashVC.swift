//
//  SplashVC.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

class SplashVC: BaseVC {
    
    // MARK: - IBOutlet
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Attributtes
    
    var presenter: SplashPresenter?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
}

// MARK: - SplashPresenterOutput

extension SplashVC: SplashPresenterOutput {
    
    func showError(text: String) {        
        self.showAlertError(text: text)
    }
    
    func updateLoading(show: Bool) {
        if show {
            self.spinner.startAnimating()
        } else {
            self.spinner.stopAnimating()
        }
    }
}
