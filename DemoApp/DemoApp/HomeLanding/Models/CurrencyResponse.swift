//
//  CountryResponse.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 12/02/21.
//

import Foundation
struct CurrencyResponse : Codable {
	let currencies : [Currency]?

	enum CodingKeys: String, CodingKey {

		case currencies = "Currencies"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		currencies = try values.decodeIfPresent([Currency].self, forKey: .currencies)
	}

}
