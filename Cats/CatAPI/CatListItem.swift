//
//  CatListItem.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import Foundation

struct CatListItem: Codable, Identifiable {
    var id: String
    var weight: Weight?
    var name: String
    var origin: String?
    var description: String
    var temperament: String?
    var lifeSpan: String?
    var wikipediaURL: String?
    var cfaURL : String?
    var vetStreetURL : String?
    var vcaHospitalsURL : String?
    var countryCodes : String?
    var countryCode : String?
    var alternateNames : String?
    var indoor : Int?
    var lap : Int?
    var adaptability: Int?
    var affectionLevel: Int?
    var childFriendly: Int?
    var dogFriendly: Int?
    var energyLevel: Int?
    var grooming: Int?
    var healthIssues: Int?
    var intelligence: Int?
    var sheddingLevel: Int?
    var socialNeeds: Int?
    var strangerFriendly: Int?
    var vocalisation: Int?
    var experimental: Int?
    var hairless: Int?
    var natural: Int?
    var rare: Int?
    var rex: Int?
    var suppressedTail: Int?
    var shortLegs: Int?
    var hypoallergenic: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case weight
        case name
        case origin
        case description
        case temperament
        case lifeSpan
        case wikipediaURL = "wikipediaUrl"
        case cfaURL = "cfaUrl"
        case vetStreetURL = "vetstreetUrl"
        case vcaHospitalsURL = "vcahospitalsUrl"
        case countryCodes
        case countryCode
        case alternateNames = "altNames"
        case indoor
        case lap
        case adaptability
        case affectionLevel
        case childFriendly
        case dogFriendly
        case energyLevel
        case grooming
        case healthIssues
        case intelligence
        case sheddingLevel
        case socialNeeds
        case strangerFriendly
        case vocalisation
        case experimental
        case hairless
        case natural
        case rare
        case rex
        case suppressedTail
        case shortLegs
        case hypoallergenic
    }
}

struct Weight: Codable {
    var imperial: String?
    var metric: String?
    
    enum CodingKeys: String, CodingKey {
        case imperial
        case metric
    }
}
