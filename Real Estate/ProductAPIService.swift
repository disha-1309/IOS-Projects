//
//  ProductAPIService.swift
//  Real Estate
//
//  Created by Droisys on 29/09/25.

import Foundation
import Combine

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case apiError(Error)
}

class ProductAPIService {
    
    //Asynchronous function which use async/await
    func fetchProducts() async throws -> [Product] {
        // Create  URL
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw NetworkError.invalidURL
        }
        
        //Use URLSession.shared for data response
        // Use try await because it is an asynchronous operation
        let (data, response) = try await URLSession.shared.data(from: url)
        
        //Check the response (HTTPURLResponse)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.noData
        }
        
        // Decode the JSON to product model
        do {
            let decoder = JSONDecoder()
            let products = try decoder.decode([Product].self, from: data)
            return products
        } catch {
            // If there is an error
            throw NetworkError.decodingError(error)
        }
    }
    
    //access the post api

//        func fetchAccountData() async throws -> [Account]? {
//            guard let url = URL(string: "https://stage-appapi-mobile-console.account360.ai/api/v2.4/Account/AccountFilter") else {
//                throw NetworkError.invalidURL
//            }
//            
//            let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InRpbSIsImdpdmVuX25hbWUiOiJUaW0iLCJmYW1pbHlfbmFtZSI6IlNhbXNvbiIsIk1pZGRsZU5hbWUiOiJrIiwiZW1haWwiOiJ0aW0uc2Ftc29uQGRyb2lzeXMuY29tIiwiQ2xpZW50Q29kZSI6IjE1IiwiVXNlckNvZGUiOiI1MjQyMzEiLCJSb2xlSWQiOiIwIiwiTWFya2V0Q29kZSI6IjY1NCIsIkxvZ2luQXNDbGllbnRDb2RlIjoiMTUiLCJMb2dpbkFzVXNlckNvZGUiOiI1MjQyMzEiLCJVc2VyUm9sZUNhdGVnb3J5IjoiRGlzdHJpYnV0b3IiLCJleHAiOjE3NjY4OTc4OTEsImlzcyI6Imh0dHA6Ly9kcm9pc3lzLmNvbS8iLCJhdWQiOiJodHRwOi8vZHJvaXN5cy5jb20vIn0.nNokoCpExqdIFipN7u-wKwDReKL_ikvScJs4QPBkk0M"
//            
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            
//            //  Headers exactly curl match
//            request.setValue("com.droisys.StageA360i", forHTTPHeaderField: "BundleId")
//            request.setValue(token, forHTTPHeaderField: "AppToken")
//            request.setValue("V. S1.2.174", forHTTPHeaderField: "AppVersion")
//            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//            request.setValue("zNiphaJww8e4qYEwJ96gVK5HTAAbAXdj", forHTTPHeaderField: "AppID")
//            request.setValue("jSzcOZo9rry6DOpLGS0TEzrTQswNVWku", forHTTPHeaderField: "OAuth")
//            request.setValue("My iPhone 15", forHTTPHeaderField: "deviceName")
//            request.setValue("iPhone", forHTTPHeaderField: "Source")
//            request.setValue("1B01F4FD-84E5-4919-911D-80512EE32A10", forHTTPHeaderField:"deviceId")
//            request.setValue("17.0", forHTTPHeaderField: "deviceVersion")
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            
//            //  Request Body exactly curl JSON
//            let requestBody: [String: Any] = [
//                "IsOrderWednesday": false,
//                "ResultCount": 0,
//                "ACDistanceLocationIndex": 0,
//                "IsCallDaysChanged": false,
//                "IsLoadTuesday": false,
//                "IsAllFineDining": false,
//                "SearchByKeyword": 2,
//                "IsLoadWednesday": false,
//                "Distance": 200,
//                "ListDepletion": [],
//                "IsLoadMonday": false,
//                "RequestSyncTime": 0,
//                "Flavor": "",
//                "A360Visibility": 1,
//                "AppCode": "3",
//                "AccountSortBy": "Distance",
//                "IsLoadSunday": false,
//                "accountSortByIndex": 0,
//                "GetResult": 0,
//                "AccountType": -1,
//                "DivisionCodeList": [322],
//                "IsOrderThursday": false,
//                "DistributorClientCode": 15,
//                "IsLoadFriday": false,
//                "IsOrderSaturday": false,
//                "Appletion": "",
//                "UserLatitude": 37.787359,
//                "Size": "",
//                "SchduleType": 0,
//                "UserLongitude": -122.408227,
//                "IsDistanceOff": false,
//                "IsOrderMonday": false,
//                "ListKeyAcctGrp": [],
//                "Keyword": "",
//                "IsLoadSaturday": false,
//                "PageIndex": 1,
//                "SearchLocationAddress": "Highland Park, MI 48203, USA",
//                "ACDistanceLocation": "",
//                "ListNBOandTopSkuBrand": [],
//                "CurrentLoc": ["coordinates": [-83.096868,42.4055925], "type": "point"],
//                "IsOrderFriday": false,
//                "SalesTypeID": -1,
//                "IsOrderSunday": false,
//                "DivisionCode": 0,
//                "CognitoUserID": 524231,
//                "UTCOffsetSeconds": 19800,
//                "AccountStatus": 0,
//                "DivisionName": "",
//                "ListNBO": [],
//                "IsLoadThursday": false,
//                "IsOrderTuesday": false,
//                "UserLocationLoc": ["coordinates": [-122.408227,37.787359], "type": "point"],
//                "ReleaseDate": "0001-01-01T00:00:00",
//                "PageSize": 20
//            ]
//            
//            //
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
//            } catch {
//                throw NetworkError.apiError(error)
//            }
//            
//            //  API Call
//            let (data, response) = try await URLSession.shared.data(for: request)
//            
//            guard let httpResponse = response as? HTTPURLResponse else {
//                throw NetworkError.noData
//            }
//            
//            if !(200...299).contains(httpResponse.statusCode) {
//                if let errorBody = String(data: data, encoding: .utf8) {
//                    print(" API Error Response Body: \(errorBody)")
//                }
//                throw NetworkError.noData
//            }
//            
//            //  Decode Response
//            do {
//                let decoder = JSONDecoder()
//                let decodeResponse = try decoder.decode(APIResponse.self, from: data)
//                return decodeResponse.result
//            } catch {
//                print(" Decoding Failed. Error: \(error)")
//                throw NetworkError.decodingError(error)
//            }
//        }
//    }

    func fetchAccountData() -> AnyPublisher<[Account], Error> {
            
            guard let url = URL(string: "https://stage-appapi-mobile-console.account360.ai/api/v2.4/Account/AccountFilter") else {
                return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
            }
            
            //Token
            let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6InRpbSIsImdpdmVuX25hbWUiOiJUaW0iLCJmYW1pbHlfbmFtZSI6IlNhbXNvbiIsIk1pZGRsZU5hbWUiOiJrIiwiZW1haWwiOiJ0aW0uc2Ftc29uQGRyb2lzeXMuY29tIiwiQ2xpZW50Q29kZSI6IjE1IiwiVXNlckNvZGUiOiI1MjQyMzEiLCJSb2xlSWQiOiIwIiwiTWFya2V0Q29kZSI6IjY1NCIsIkxvZ2luQXNDbGllbnRDb2RlIjoiMTUiLCJMb2dpbkFzVXNlckNvZGUiOiI1MjQyMzEiLCJVc2VyUm9sZUNhdGVnb3J5IjoiRGlzdHJpYnV0b3IiLCJleHAiOjE3NjY4OTc4OTEsImlzcyI6Imh0dHA6Ly9kcm9pc3lzLmNvbS8iLCJhdWQiOiJodHRwOi8vZHJvaXN5cy5jb20vIn0.nNokoCpExqdIFipN7u-wKwDReKL_ikvScJs4QPBkk0M"
            
            // Request setup
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("com.droisys.StageA360i", forHTTPHeaderField: "BundleId")
            request.setValue(token, forHTTPHeaderField: "AppToken")
            request.setValue("V. S1.2.174", forHTTPHeaderField: "AppVersion")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("zNiphaJww8e4qYEwJ96gVK5HTAAbAXdj", forHTTPHeaderField: "AppID")
            request.setValue("jSzcOZo9rry6DOpLGS0TEzrTQswNVWku", forHTTPHeaderField: "OAuth")
            request.setValue("My iPhone 15", forHTTPHeaderField: "deviceName")
            request.setValue("iPhone", forHTTPHeaderField: "Source")
            request.setValue("1B01F4FD-84E5-4919-911D-80512EE32A10", forHTTPHeaderField:"deviceId")
            request.setValue("17.0", forHTTPHeaderField: "deviceVersion")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //  Body
            let requestBody: [String: Any] = [
                "IsOrderWednesday": false,
                "ResultCount": 0,
                "ACDistanceLocationIndex": 0,
                "IsCallDaysChanged": false,
                "IsLoadTuesday": false,
                "IsAllFineDining": false,
                "SearchByKeyword": 2,
                "IsLoadWednesday": false,
                "Distance": 200,
                "ListDepletion": [],
                "IsLoadMonday": false,
                "RequestSyncTime": 0,
                "Flavor": "",
                "A360Visibility": 1,
                "AppCode": "3",
                "AccountSortBy": "Distance",
                "IsLoadSunday": false,
                "accountSortByIndex": 0,
                "GetResult": 0,
                "AccountType": -1,
                "DivisionCodeList": [322],
                "IsOrderThursday": false,
                "DistributorClientCode": 15,
                "IsLoadFriday": false,
                "IsOrderSaturday": false,
                "Appletion": "",
                "UserLatitude": 37.787359,
                "Size": "",
                "SchduleType": 0,
                "UserLongitude": -122.408227,
                "IsDistanceOff": false,
                "IsOrderMonday": false,
                "ListKeyAcctGrp": [],
                "Keyword": "",
                "IsLoadSaturday": false,
                "PageIndex": 1,
                "SearchLocationAddress": "Highland Park, MI 48203, USA",
                "ACDistanceLocation": "",
                "ListNBOandTopSkuBrand": [],
                "CurrentLoc": ["coordinates": [-83.096868,42.4055925], "type": "point"],
                "IsOrderFriday": false,
                "SalesTypeID": -1,
                "IsOrderSunday": false,
                "DivisionCode": 0,
                "CognitoUserID": 524231,
                "UTCOffsetSeconds": 19800,
                "AccountStatus": 0,
                "DivisionName": "",
                "ListNBO": [],
                "IsLoadThursday": false,
                "IsOrderTuesday": false,
                "UserLocationLoc": ["coordinates": [-122.408227,37.787359], "type": "point"],
                "ReleaseDate": "0001-01-01T00:00:00",
                "PageSize": 20
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody)
            
            //Combine pipeline
        //observe the network request
            return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { output -> Data in
                    guard let response = output.response as? HTTPURLResponse,
                          (200...299).contains(response.statusCode) else {
                        
                        //covert bytes into readable string
                        let body = String(data: output.data, encoding: .utf8) ?? "Unknown error"
                        print("API Error: \(body)")
                        throw NetworkError.noData
                    }
                    return output.data
                }
                .decode(type: APIResponse.self, decoder: JSONDecoder())
                .tryMap { response in
                    guard let result = response.result else {
                        throw NetworkError.noData
                    }
                    return result
                }
                .receive(on: DispatchQueue.main)
        //hide the publisher exact type and return generic type any publisher
                .eraseToAnyPublisher()
        }
    }
