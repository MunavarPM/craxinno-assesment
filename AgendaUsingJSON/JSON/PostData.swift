////
////  PostData.swift
////  AgendaUsingJSON
////
////  Created by MUNAVAR PM on 28/11/23.
////
//
//import Foundation
//
//
//struct Data : Codable {
//    let id : Int?
//    let name : String?
//    let start_date : String?
//    let end_date : String?
//    let my_agenda : Int?
//    let attendees : [Attendees]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case name = "name"
//        case start_date = "start_date"
//        case end_date = "end_date"
//        case my_agenda = "my_agenda"
//        case attendees = "attendees"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        start_date = try values.decodeIfPresent(String.self, forKey: .start_date)
//        end_date = try values.decodeIfPresent(String.self, forKey: .end_date)
//        my_agenda = try values.decodeIfPresent(Int.self, forKey: .my_agenda)
//        attendees = try values.decodeIfPresent([Attendees].self, forKey: .attendees)
//    }
//
//}
//
//struct Attendees : Codable {
//    let image : String?
//    let company_name : String?
//    let name : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case image = "image"
//        case company_name = "company_name"
//        case name = "name"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        image = try values.decodeIfPresent(String.self, forKey: .image)
//        company_name = try values.decodeIfPresent(String.self, forKey: .company_name)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//}

struct PostData: Codable {
    let replyCode: String
    let replyMsg: String
    let data: [Agenda]
    let cmd: String
    let imgPath: String
    let attendeeImgPath: String
}

struct Agenda: Codable {
    let id: Int
    let name: String
    let start_date: String
    let end_date: String
    let my_agenda: Int
    let attendees: [Attendee]
}

struct Attendee: Codable {
    let image: String
    let company_name: String
    let name: String
}

