//
//  ApiService.swift
//  Api Calling
//
//  Created by Droisys on 16/02/26.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    private init() {}
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response , error in
        
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {return}
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
