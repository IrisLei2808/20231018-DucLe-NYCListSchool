//
//  Score.swift
//  20231018-DucLe-NYCSchools
//
//  Created by Duc Le on 10/21/23.
//

import Foundation

struct Score: Codable {
    let dbn: String
    let satMathAvgScore: String
    let satCriticalReadingAvgScore: String
    let satWritingAvgScore: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case satMathAvgScore = "sat_math_avg_score"
        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
        case satWritingAvgScore = "sat_writing_avg_score"
    }
}
