//
//  BaseVC.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 25/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import UIKit

protocol BaseVCInput {
    func showAlertError(text: String)
}

class BaseVC: UIViewController {
 
}

// MARK: - BaseVCInput

extension BaseVC: BaseVCInput {
    
    func showAlertError(text: String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }
}
