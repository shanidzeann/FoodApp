//
//  NetworkManager.swift
//  FoodApp
//
//  Created by Anna Shanidze on 25.03.2022.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    
    private let jsonParser: JSONParserProtocol!
    
    let pizzaURL = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=pizza&apiKey=\(yourKey)")
    let burgerURL = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=burger&apiKey=\(yourKey)")
    let soupURL = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=soup&apiKey=\(yourKey)")
    let wokURL = URL(string: "https://api.spoonacular.com/food/menuItems/search?query=wok&apiKey=\(yourKey)")
    
    init(jsonParser: JSONParserProtocol) {
        self.jsonParser = jsonParser
    }
    
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
                self?.jsonParser.parseJSON(data: data) { (result: Result<T, Error>) in
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
}
