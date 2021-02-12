//
//  FlightsResponse.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 11/02/21.
//

import Foundation
import SwiftUI
import Combine

struct FlightsResponse : Codable, Identifiable {
    var id = UUID().uuidString
	let quotes : [Quotes]?
	let carriers : [Carriers]?
	let places : [Places]?
	let currencies : [Currency]?

	enum CodingKeys: String, CodingKey {

		case quotes = "Quotes"
		case carriers = "Carriers"
		case places = "Places"
		case currencies = "Currencies"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		quotes = try values.decodeIfPresent([Quotes].self, forKey: .quotes)
		carriers = try values.decodeIfPresent([Carriers].self, forKey: .carriers)
		places = try values.decodeIfPresent([Places].self, forKey: .places)
		currencies = try values.decodeIfPresent([Currency].self, forKey: .currencies)
	}

}

struct Carriers : Codable {
    let carrierId : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case carrierId = "CarrierId"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        carrierId = try values.decodeIfPresent(Int.self, forKey: .carrierId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

struct Currency : Codable {
    let code : String?
    let symbol : String?
    let thousandsSeparator : String?
    let decimalSeparator : String?
    let symbolOnLeft : Bool?
    let spaceBetweenAmountAndSymbol : Bool?
    let roundingCoefficient : Int?
    let decimalDigits : Int?

    enum CodingKeys: String, CodingKey {

        case code = "Code"
        case symbol = "Symbol"
        case thousandsSeparator = "ThousandsSeparator"
        case decimalSeparator = "DecimalSeparator"
        case symbolOnLeft = "SymbolOnLeft"
        case spaceBetweenAmountAndSymbol = "SpaceBetweenAmountAndSymbol"
        case roundingCoefficient = "RoundingCoefficient"
        case decimalDigits = "DecimalDigits"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        thousandsSeparator = try values.decodeIfPresent(String.self, forKey: .thousandsSeparator)
        decimalSeparator = try values.decodeIfPresent(String.self, forKey: .decimalSeparator)
        symbolOnLeft = try values.decodeIfPresent(Bool.self, forKey: .symbolOnLeft)
        spaceBetweenAmountAndSymbol = try values.decodeIfPresent(Bool.self, forKey: .spaceBetweenAmountAndSymbol)
        roundingCoefficient = try values.decodeIfPresent(Int.self, forKey: .roundingCoefficient)
        decimalDigits = try values.decodeIfPresent(Int.self, forKey: .decimalDigits)
    }

}

struct OutboundLeg : Codable {
    let carrierIds : [Int]?
    let originId : Int?
    let destinationId : Int?
    let departureDate : String?

    enum CodingKeys: String, CodingKey {
        case carrierIds = "CarrierIds"
        case originId = "OriginId"
        case destinationId = "DestinationId"
        case departureDate = "DepartureDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        carrierIds = try values.decodeIfPresent([Int].self, forKey: .carrierIds)
        originId = try values.decodeIfPresent(Int.self, forKey: .originId)
        destinationId = try values.decodeIfPresent(Int.self, forKey: .destinationId)
        departureDate = try values.decodeIfPresent(String.self, forKey: .departureDate)
    }

}

struct Places : Codable {
    let name : String?
    let type : String?
    let placeId : Int?
    let skyscannerCode : String?

    enum CodingKeys: String, CodingKey {

        case name = "Name"
        case type = "Type"
        case placeId = "PlaceId"
        case skyscannerCode = "SkyscannerCode"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        placeId = try values.decodeIfPresent(Int.self, forKey: .placeId)
        skyscannerCode = try values.decodeIfPresent(String.self, forKey: .skyscannerCode)
    }

}

struct Quotes: Codable, Identifiable {
    var id = UUID().uuidString
    let quoteId : Int?
    let minPrice : Int?
    let direct : Bool?
    let outboundLeg : OutboundLeg?
    let quoteDateTime : String?

    enum CodingKeys: String, CodingKey {

        case quoteId = "QuoteId"
        case minPrice = "MinPrice"
        case direct = "Direct"
        case outboundLeg = "OutboundLeg"
        case quoteDateTime = "QuoteDateTime"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quoteId = try values.decodeIfPresent(Int.self, forKey: .quoteId)
        minPrice = try values.decodeIfPresent(Int.self, forKey: .minPrice)
        direct = try values.decodeIfPresent(Bool.self, forKey: .direct)
        outboundLeg = try values.decodeIfPresent(OutboundLeg.self, forKey: .outboundLeg)
        quoteDateTime = try values.decodeIfPresent(String.self, forKey: .quoteDateTime)
    }

}
