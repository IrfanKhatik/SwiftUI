//
//  APISession.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import Foundation
import Combine
import UIKit

struct APISession: APIService {
    func request<T>(with builder: RequestBuilder) -> AnyPublisher<T, APIError> where T: Decodable {
        // Create an instance of JSONDecoder to decode our incoming data.
        let decoder = JSONDecoder()
        // We can use the built in convertFromSnakeCase keyDecodingStrategy to convert the incoming snake case to camel case.
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        // This is one of those built-in publishers,
        // It takes a URLRequest as a parameter - which we provide via our RequestBuilder instance,
        // RequestBuilder instance - performs a network request and returns a publisher of type URLSession.DataTaskPublisher.
        return URLSession.shared
            .dataTaskPublisher(for: builder.urlRequest)
            // This operator specifies the scheduler we'd like to receive the data on,
            // in this case we want to receive our data on the Main Thread.
            .receive(on: DispatchQueue.main)
            // This is an interesting one, if an error occurs mapError will provide an error of type Error that we need to convert - or 'map'
            // - into a type of APIError, after all that's what we've told our publisher to expect in the return type of this function.
            // If something fails at this point we return the type APIError.unknown.
            .mapError { _ in .unknown }
            // flatMap allows us to transform the incoming data from our URLSession.dataTaskPublisher into a new publisher
            // who's type matches the types we expect.
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                if let response = response as? HTTPURLResponse {
                    if (200...299).contains(response.statusCode) {
                        // Here's where we do the transformation mentioned above,
                        // the Just publisher emits a single value, we pass in our data here
                        // which is then handed off to decode which transforms it to our type T (which is of type Decodable),
                        // we then use mapError which returns decodingError should something go wrong with the decoding,
                        // and finally eraseToAnyPublisher to type erase our complex publisher into something more manageable.
                        return Just(data)
                            .decode(type: T.self, decoder: decoder)
                            .mapError {_ in .decodingError}
                            .eraseToAnyPublisher()
                    } else {
                        // We use the Fail publisher here and return .httpError with the provided http status code from our response.
                        // Fail finishes immediately and provides an error of the type we specified in the return type.
                        // For example, if we tried to use Fail with an instance of NSError here we'd get a compile time error,
                        // as our function expects to return an error of type APIError.
                        return Fail(error: APIError.httpError(response.statusCode))
                            .eraseToAnyPublisher()
                    }
                }
                return Fail(error: APIError.unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func requestImage(with url: String) -> AnyPublisher<UIImage, APIError> {
        guard let url = URL(string: url)
        else {
            return Fail(error: .decodingError)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .mapError { _ in .unknown }
            .flatMap { data, response -> AnyPublisher<UIImage, APIError> in
                if let image = UIImage(data: data) {
                    return Just(image)
                        .mapError {_ in .decodingError }
                        .eraseToAnyPublisher()
                }
                return Fail(error: .unknown)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
