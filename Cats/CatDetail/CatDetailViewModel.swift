//
//  CatDetailViewModel.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import Foundation
import SwiftUI
import Combine
import UIKit

class CatDetailViewModel: ObservableObject, CatService {
    var cancellables = Set<AnyCancellable>()
    
    @Published var catImage: UIImage?
    
    @Published var showErrorAlert = false
    
    var alertMessage = "Unknown error"
    
    private let catItem: CatItem
    
    internal var apiSession: APIService
    
    var catName: String {
        return self.catItem.name ?? ""
    }
    
    var desc: String {
        return self.catItem.desc ?? ""
    }
    
    init(_ catItem: CatItem, apiService: APIService = APISession()) {
        self.catItem = catItem
        self.apiSession = apiService
    }
    
    // Download cat/breed details
    func getCatDetail() {
        if let imageData = self.catItem.image {
            self.catImage = UIImage(data: imageData)
            return
        }
        
        guard let catId = catItem.id else { return }
        
        let cancellable = self.getCatDetail(catId: catId)
            .sink {[weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.alertMessage = "\((error as NSError).localizedDescription)"
                    self?.showErrorAlert = true
                case .finished:
                    break
                }
            } receiveValue: { (detail) in
                guard let catDetail = detail.first else {
                    return
                }
                
                self.catItem.url = catDetail.url
                DatabaseManager.shared.saveContext()
                self.getCatImage()
            }
        cancellables.insert(cancellable)
    }
    
    // Download cat image
    private func getCatImage() {
        guard let url = catItem.url else {
            return
        }
        
        let cancellable = self.getCatImage(url: url)
            .sink {[weak self] (result) in
                switch result {
                case .failure(let error):
                    self?.alertMessage = "\((error as NSError).localizedDescription)"
                    self?.showErrorAlert = true
                case .finished:
                    break
                }
            } receiveValue: { (image) in
                self.catImage = image
                self.catItem.image = image.pngData()
                DatabaseManager.shared.saveContext()
            }
        cancellables.insert(cancellable)
    }
}
