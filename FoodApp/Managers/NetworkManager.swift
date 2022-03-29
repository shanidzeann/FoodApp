//
//  NetworkManager.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    let pizzaURL = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=pizza&apiKey=79cc381a96da454889639c69fa3edc2d")
    let burgerURL = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=burger&apiKey=79cc381a96da454889639c69fa3edc2d")
    let soupURL = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=soup&apiKey=79cc381a96da454889639c69fa3edc2d")
    let wokURL = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=wok&apiKey=79cc381a96da454889639c69fa3edc2d")
    
    func downloadMenu(completion: @escaping ([Result<(url: String, menu: Menu), Error>]) -> Void) {
        guard let pizzaURL = pizzaURL,
              let burgerURL = burgerURL,
              let soupURL = soupURL,
              let wokURL = wokURL else { return }
        
        let urls = [pizzaURL, burgerURL, soupURL, wokURL]
        var menuCollection: [Result<(url: String, menu: Menu), Error>] = []
        let urlDownloadGroup = DispatchGroup()
        
        urls.forEach { url in
            urlDownloadGroup.enter()
            getData(url: url) { (result: Result<Menu, Error>)  in
                switch result {
                case .success(let result):
                    menuCollection.append(.success((url.absoluteString, result)))
                    urlDownloadGroup.leave()
                case .failure(let error):
                    menuCollection.append(.failure(error))
                    urlDownloadGroup.leave()
                }
            }
            urlDownloadGroup.wait()
        }
        
        completion(menuCollection)
    }
    
    
    private func getData<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                self?.parseJSON(data: data) { (result: Result<T, Error>) in
                    switch result {
                    case .success(let array):
                        completion(.success(array))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    private func parseJSON<T: Decodable>(data: Data, completion: @escaping (Result<T, Error>) -> Void)  {
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
