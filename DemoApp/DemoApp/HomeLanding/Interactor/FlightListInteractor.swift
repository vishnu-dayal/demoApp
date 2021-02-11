//
//  FlightListInteractor.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 11/02/21.
//

import Foundation
import Combine
import SwiftUI


protocol ListInteractorInputProtocols {
    func callAPIToGetFlights()
    var presenter: ListInteractorOutputProtocols? { set get }
    var quotes: [Quotes]? { set get }
}

protocol ListInteractorOutputProtocols {
    
    
}

class FlightListInteractor: ObservableObject, ListInteractorInputProtocols {
    var presenter: ListInteractorOutputProtocols?
    var carriers : [Carriers]?
    var places : [Places]?
    var currencies : [Currencies]?
    @Published var quotes: [Quotes]? = []
    
    var response: FlightsResponse? {
        didSet {
            places = response?.places
            currencies = response?.currencies
            carriers = response?.carriers
            DispatchQueue.main.async {
                self.quotes = self.response?.quotes
            }
        }
    }
    
    func getFlightName(carrierId: Int?) -> String? {
        let carrierModel = carriers?.filter({ (carrier) -> Bool in
            return carrier.carrierId == carrierId
        })
        return carrierModel?.first?.name
    }

    func getPlaceName(id: Int?) -> (String?, String?) {
        let placeModel = places?.filter({ (place) -> Bool in
            return place.placeId == id
        })
        return (placeModel?.first?.name, placeModel?.first?.skyscannerCode)
    }
    
    func getCurrencySymbol(quotes: Quotes?) -> String {
        let currency = currencies?.first
        return  String(format: "%@%d",currency?.symbol ?? "$", quotes?.minPrice ?? 0.0)
    }

    
    func callAPIToGetFlights() {
        let request = APIRequest(apiKey: Constants().apiKey, endPoint: "FR/eur/en-US/uk/us/anytime")
        APIManager.sharedInstance.getFlights(request: request, completionHandler: { (jsonData) in
            if let data = jsonData {
                self.parseQuotesResponse(json: data)
            }
        })
    }
    
    
    func callListOfCountriesAPI() {
        let locale = Locale.current
        let request = APIRequest(apiKey: Constants().apiKey, endPoint: locale.identifier)
        APIManager.sharedInstance.getListOfCountries(request: request, completionHandler: { (jsonData) in
            if let data = jsonData {
//                self.parseQuotesResponse(json: data)
            }
        })
    }
    
    func callListOfCurrenciesAPI() {
        let request = APIRequest(apiKey: Constants().apiKey, endPoint: "")
        APIManager.sharedInstance.getListOfCurrencies(request: request, completionHandler: { (jsonData) in
            if let data = jsonData {
//                self.parseQuotesResponse(json: data)
            }
        })
    }
    
    private func parseQuotesResponse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonResponse = try? decoder.decode(FlightsResponse.self, from: json) {
            response = jsonResponse
        }
    }
}
