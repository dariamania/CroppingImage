//
//  NetworkManager.swift
//  CroppingImage
//
//  Created by Dariia Pavlovskaya on 17.12.2021.
//

import UIKit

protocol NetworkManagerDelegate: AnyObject {
    func didGetNews(news: [ImageObject])
}

class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    func getImages() {
        DispatchQueue.main.async {
            guard let remoteUrl = URL(string: "https://api.npoint.io/8a0d91721a5d84f149df") else { return }
            let request = URLRequest(url: remoteUrl)
            
            URLSession.shared.dataTask(with: request) { data, resp, error in if let data = data {
                if let decoderResp = try? JSONDecoder().decode(Images.self, from: data)
                {
                    DispatchQueue.main.sync {
                        self.delegate?.didGetNews(news: decoderResp.items)
                    }
                }
            }
                
            }.resume()
        }
    }
}
