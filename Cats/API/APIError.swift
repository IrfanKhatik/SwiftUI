//
//  APIError.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import Foundation

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}
