//
//  CountryResponse.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 12/02/21.
//

import Foundation
struct CountryResponse : Codable {
	let countries : [Country]?

	enum CodingKeys: String, CodingKey {

		case countries = "Countries"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		countries = try values.decodeIfPresent([Country].self, forKey: .countries)
	}
}

struct Country : Codable {
    let code : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case code = "Code"
        case name = "Name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
