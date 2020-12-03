//
//  CatService.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import Foundation
import Combine
import UIKit

protocol CatService {
    var apiSession: APIService {get}
    
    func getCatList() -> AnyPublisher<[CatListItem], APIError>
    func getCatDetail(catId: String) -> AnyPublisher<[CatDetail], APIError>
    func getCatImage(url:String) -> AnyPublisher<UIImage, APIError>
}

extension CatService {
    
    func getCatList() -> AnyPublisher<[CatListItem], APIError> {
        return apiSession.request(with: CatEndpoint.catList)
            .eraseToAnyPublisher()
    }
    
    func getCatDetail(catId: String) -> AnyPublisher<[CatDetail], APIError> {
        return apiSession.request(with: CatEndpoint.catDetail(catId))
            .eraseToAnyPublisher()
    }
    
    func getCatImage(url:String) -> AnyPublisher<UIImage, APIError> {
        return apiSession.requestImage(with: url)
            .eraseToAnyPublisher()
    }
}
