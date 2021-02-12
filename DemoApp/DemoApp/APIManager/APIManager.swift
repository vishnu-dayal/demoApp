//
//  APIManager.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 11/02/21.
//

import Foundation

struct Constants {
    let apiKey = "prtl6749387986743898559646983194"
    let apiBaseUrl = "http://partners.api.skyscanner.net/apiservices/%@"
    let apiBrowseQuotes = "browsequotes/v1.0/"
    let apiBrowseCountries = "reference/v1.0/countries/"
    let apiBrowseCurrencies = "reference/v1.0/currencies/"
}

typealias CompletionHandler = (_ json: Data?) -> Void
struct APIManager {
    static let sharedInstance = APIManager()
    private init() {
        
    }
    
    func getFlights(request: APIRequest,  completionHandler: @escaping CompletionHandler) {
        guard let apiKey = request.apiKey, let endPoint = request.endPoint else {
            return
        }
        var apiPath = String(format: Constants().apiBaseUrl, Constants().apiBrowseQuotes)
        apiPath = apiPath.appending("\(endPoint)")
        apiPath = apiPath.appending("?apikey=\(apiKey)")
        apiCall(apiUrl: apiPath, completionHandler: completionHandler)
    }
    
    func getListOfCountries(request: APIRequest,  completionHandler: @escaping CompletionHandler) {
        guard let apiKey = request.apiKey, let endPoint = request.endPoint else {
            return
        }
        var apiPath = String(format: Constants().apiBaseUrl, Constants().apiBrowseCountries)
        apiPath = apiPath.appending("\(endPoint)")
        apiPath = apiPath.appending("?apikey=\(apiKey)")
        apiCall(apiUrl: apiPath, completionHandler: completionHandler)
    }
    
    func getListOfCurrencies(request: APIRequest,  completionHandler: @escaping CompletionHandler) {
        guard let apiKey = request.apiKey, let endPoint = request.endPoint else {
            return
        }
        var apiPath = String(format: Constants().apiBaseUrl, Constants().apiBrowseCurrencies)
        apiPath = apiPath.appending("\(endPoint)")
        apiPath = apiPath.appending("?apikey=\(apiKey)")
        apiCall(apiUrl: apiPath, completionHandler: completionHandler)
    }
    
    private func apiCall(apiUrl: String,  completionHandler: @escaping CompletionHandler) {
        guard let url = URL(string: apiUrl) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                completionHandler(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                completionHandler(nil)
                return
            }
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }.resume()
    }
}

struct APIRequest {
    let apiKey: String?
    let endPoint: String?
}
