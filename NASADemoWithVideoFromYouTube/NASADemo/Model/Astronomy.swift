

import Foundation
struct Astronomy : Codable {
	let copyright : String?
	let date : String?
	let explanation : String?
	let media_type : String?
	let service_version : String?
	let title : String?
	let url : String?

	enum CodingKeys: String, CodingKey {

		case copyright = "copyright"
		case date = "date"
		case explanation = "explanation"
		case media_type = "media_type"
		case service_version = "service_version"
		case title = "title"
		case url = "url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
		date = try values.decodeIfPresent(String.self, forKey: .date)
		explanation = try values.decodeIfPresent(String.self, forKey: .explanation)
		media_type = try values.decodeIfPresent(String.self, forKey: .media_type)
		service_version = try values.decodeIfPresent(String.self, forKey: .service_version)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		url = try values.decodeIfPresent(String.self, forKey: .url)
	}

}
