//
//  CatDetail.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import Foundation

// MARK: - CatDetail
struct CatDetail: Codable, Identifiable {
    var id: String?
    var url: String?
    var height: Int?
    var width: Int?
    var breeds: [CatListItem]?
}
