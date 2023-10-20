//
//  School.swift
//  20231018-DucLe-NYCSchools
//
//  Created by Duc Le on 10/21/23.
//

import Foundation

struct School: Codable, Identifiable {
    let id: String?
    let schoolName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "dbn"
        case schoolName = "school_name"
    }
}
