/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct AgendaData : Codable {
	let id : Int?
	let user_id : Int?
	let event_id : Int?
	let name : String?
	let start_date : String?
	let end_date : String?
	let description : String?
	let sponsor_name : String?
	let sponsor_img : String?
	let location_name : String?
	let header_img : String?
	let my_agenda : Int?
	let attendees : [String]?
	let register_links : [Register_links]?
	let agenda_documents : [Agenda_documents]?
	let agenda_speakers : [Agenda_speakers]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user_id = "user_id"
		case event_id = "event_id"
		case name = "name"
		case start_date = "start_date"
		case end_date = "end_date"
		case description = "description"
		case sponsor_name = "sponsor_name"
		case sponsor_img = "sponsor_img"
		case location_name = "location_name"
		case header_img = "header_img"
		case my_agenda = "my_agenda"
		case attendees = "attendees"
		case register_links = "register_links"
		case agenda_documents = "agenda_documents"
		case agenda_speakers = "agenda_speakers"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
		event_id = try values.decodeIfPresent(Int.self, forKey: .event_id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
		end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		sponsor_name = try values.decodeIfPresent(String.self, forKey: .sponsor_name)
		sponsor_img = try values.decodeIfPresent(String.self, forKey: .sponsor_img)
		location_name = try values.decodeIfPresent(String.self, forKey: .location_name)
		header_img = try values.decodeIfPresent(String.self, forKey: .header_img)
		my_agenda = try values.decodeIfPresent(Int.self, forKey: .my_agenda)
		attendees = try values.decodeIfPresent([String].self, forKey: .attendees)
		register_links = try values.decodeIfPresent([Register_links].self, forKey: .register_links)
		agenda_documents = try values.decodeIfPresent([Agenda_documents].self, forKey: .agenda_documents)
		agenda_speakers = try values.decodeIfPresent([Agenda_speakers].self, forKey: .agenda_speakers)
	}

}
