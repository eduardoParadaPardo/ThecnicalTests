//
//  ServicesManager.swift
//  TechnicalTest
//
//  Created by eduardo parada pardo on 23/5/22.
//  Copyright © 2022 eduardo parada pardo. All rights reserved.
//

import Foundation
import UIKit

protocol ServicesManagerOutput {
    func fetchSuperHeroDidFinsh(result: ServiceResult<Any>)
}

protocol ServicesManagerInput {
    func fetchSuperHeroes()
    func fetchSuperHero(id: String)
    func downloadImag(url: String, completion: @escaping (UIImage?) -> Void)
}

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

enum ServiceResult<T> {
    case success(T)
    case error(error: TTError)
}

class ServicesManager {
        
    var output: ServicesManagerOutput?
    
    // MARK: - Private method
    
    private func launchService(url: String, type: RequestType, completion: @escaping (ServiceResult<Any>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.error(error: TTError(type: .urlNil)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
                 
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(.error(error: TTError(type: .error(error: error))))
            } else {
                guard let data = data else {
                    completion(.error(error: TTError(type: .dataNil)))
                    return
                }
                completion(.success(data))
            }
        }

        task.resume()
    }
}

// MARK: - ServicesManagerInput

extension ServicesManager: ServicesManagerInput {
    
    func fetchSuperHeroes() {
        let timeStamp = Date().timeIntervalSince1970
        let hash = "\(timeStamp)\(Config.secretkey)\(Config.apikey)"
        guard let hashMd5 = MD5Helper.MD5(string: hash) else {
            self.output?.fetchSuperHeroDidFinsh(result: .error(error: TTError(type: .invalidParams)))
            return
        }
        
        // Create url
        let tsPart = "ts=" + "\(timeStamp)"
        let apiKey = "&apikey=" + Config.apikey
        let hastPart = "&hash=" + hashMd5
        let url = Config.baseUrl + "characters?" + tsPart + apiKey + hastPart
                
        self.launchService(url: url, type: .get) { result in
            switch result {
            case .success(let data):
                guard let data = data as? Data, let text = String(data: data, encoding: .utf8) else {
                    self.output?.fetchSuperHeroDidFinsh(result: .error(error: TTError(type: .dataNil)))
                    return
                }
                let json = JSONSerialize.parser(string: text)
                
                self.output?.fetchSuperHeroDidFinsh(result: .success(json))
            case .error(let error):
                self.output?.fetchSuperHeroDidFinsh(result: .error(error: error))
            }
        }
    }
    
    func fetchSuperHero(id: String) {
        let timeStamp = Date().timeIntervalSince1970
        let hash = "\(timeStamp)\(Config.secretkey)\(Config.apikey)"
        guard let hashMd5 = MD5Helper.MD5(string: hash) else {
            return
        }
        
        // Create url
        let tsPart = "ts=" + "\(timeStamp)"
        let apiKey = "&apikey=" + Config.apikey
        let hastPart = "&hash=" + hashMd5
        let url = Config.baseUrl + "characters/" + id + "?" + tsPart + apiKey + hastPart

        self.launchService(url: url, type: .get) { result in
            switch result {
            case .success(let data):
                guard let data = data as? Data, let text = String(data: data, encoding: .utf8) else {
                    self.output?.fetchSuperHeroDidFinsh(result: .error(error: TTError(type: .dataNil)))
                    return
                }
                let json = JSONSerialize.parser(string: text)
                
                self.output?.fetchSuperHeroDidFinsh(result: .success(json))
            case .error(let error):
                self.output?.fetchSuperHeroDidFinsh(result: .error(error: error))
            }
        }
    }
    
    func downloadImag(url: String, completion: @escaping (UIImage?) -> Void) {
        self.launchService(url: url, type: .get) { result in
            switch result {
            case .success(let data):
                guard let data = data as? Data else {
                    print("Data is nil - uimage")
                    return
                }
                completion(UIImage(data: data))
                
            case .error:
                completion(nil)
            }
        }
    }
}
