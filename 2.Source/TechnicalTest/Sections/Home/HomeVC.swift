//
//  HomeVC.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 30/09/2019.
//  Copyright © 2019 eduardo parada pardo. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Attributtes
    
    var presenter: HomePresenter?
    
    // MARK: - Private Attributtes
    
    private var superHeroList: [SuperHero] = []
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.localize()
        self.presenter?.viewDidLoad()
    }
    
    private func localize() {
        self.title = "Super heroes"
    }
}

// MARK: - HomePresenterOutput

extension HomeVC: HomePresenterOutput {
    
    func showSuperHeroList(with list: [SuperHero]) {
        self.superHeroList = list
        self.tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.superHeroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let superHeroData = self.superHeroList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.superHero, for: indexPath) as? SuperHeroCell
        cell?.bindData(from: superHeroData)
        return cell ?? UITableViewCell()        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let superHeroData = self.superHeroList[indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.userDidTapSuperHero(superHero: superHeroData)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}
