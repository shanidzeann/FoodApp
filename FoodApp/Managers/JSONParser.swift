//
//  JSONParser.swift
//  FoodApp
//
//  Created by Anna Shanidze on 22.04.2022.
//

import Foundation

final class JSONParser: JSONParserProtocol {
    func parseJSON<T>(data: Data, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
            completion(.failure(DecodingError.dataCorrupted(context)))
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(DecodingError.keyNotFound(key, context)))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(DecodingError.valueNotFound(value, context)))
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
            completion(.failure(DecodingError.typeMismatch(type, context)))
        } catch {
            completion(.failure(error))
        }
    }
}
