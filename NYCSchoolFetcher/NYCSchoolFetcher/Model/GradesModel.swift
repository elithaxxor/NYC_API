//
//  GradesModel.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import Foundation

///https://data.cityofnewyork.us/resource/f9bf-2cp4.json


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

import Foundation

// MARK: - School
struct Grades: Codable {
    let dbn, schoolName, numOfSatTestTakers, satCriticalReadingAvgScore: String
    let satMathAvgScore, satWritingAvgScore: String

    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName
        case numOfSatTestTakers
        case satCriticalReadingAvgScore
        case satMathAvgScore
        case satWritingAvgScore
    }
    
    
    var DBN : String {
        print("[+] Sat DBN received")
        return dbn
    }
    
    var SchoolName : String {
        print("[+] Sat SchoolName received ")
        return schoolName
    }
    


    var SatCriticalReadingAvgScore : String {
        print("[+] satCriticalReadingAvgScore received ")
        return satCriticalReadingAvgScore
    }
    
    var SatWritingAvgScore : String {
        print("[+] satWritingAvgScore received ")
        return satWritingAvgScore
    }
    
    
    var SatMathAvgScore : String {
        print("[+] satMathAvgScore received ")
        return satMathAvgScore
    }


    


    
    /// TO FETCH GRADES
    ///
    func fetchGrades() -> Grades {
        return Grades(dbn: dbn, schoolName: schoolName, numOfSatTestTakers: numOfSatTestTakers, satCriticalReadingAvgScore: satCriticalReadingAvgScore, satMathAvgScore: satMathAvgScore, satWritingAvgScore: satWritingAvgScore)
    }
}


//   let grades = try? JSONDecoder().decode(School.self, from: jsonData)
