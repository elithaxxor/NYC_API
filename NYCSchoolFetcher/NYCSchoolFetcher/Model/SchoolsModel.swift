//
//  SchoolsModel.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//



import Foundation

// MARK: - School Model
///... sample data https://data.cityofnewyork.us/resource/s3k6-pzi2.json
///
struct Schools: Codable  {
    let dbn, schoolName, boro, overviewParagraph: String
    let school10ThSeats, academicopportunities1, academicopportunities2, ellPrograms: String
    let neighborhood, buildingCode, location, phoneNumber: String
    let faxNumber, schoolEmail, website, subway: String
    let bus, grades2018, finalgrades, totalStudents: String
    let extracurricularActivities, schoolSports: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName
        case boro
        case overviewParagraph
        case school10ThSeats
        case academicopportunities1, academicopportunities2
        case ellPrograms
        case neighborhood
        case buildingCode
        case location
        case phoneNumber
        case faxNumber
        case schoolEmail
        case website, subway, bus, grades2018, finalgrades
        case totalStudents
        case extracurricularActivities
        case schoolSports
    }
    
    
    var SchoolName : String {
        print("[+] received school name")
        return schoolName
    }
    
    var DBN : String {
        print("[+] received DBN")
        return dbn
    }
    
    var OverviewParagraph : String {
        print("[+] received overview paragraph ")
        return overviewParagraph
    }
    
    /// TO FETCH SCHOOL MODELS
    func fetchSchools() -> Schools {
        return Schools(dbn: dbn, schoolName: schoolName, boro: boro, overviewParagraph: overviewParagraph, school10ThSeats: school10ThSeats, academicopportunities1: academicopportunities1, academicopportunities2: academicopportunities2, ellPrograms: ellPrograms, neighborhood: neighborhood, buildingCode: buildingCode, location: location, phoneNumber: phoneNumber, faxNumber: faxNumber, schoolEmail: schoolEmail, website: website, subway: subway, bus: bus, grades2018: grades2018, finalgrades: finalgrades, totalStudents: totalStudents, extracurricularActivities: extracurricularActivities, schoolSports: schoolSports)
    }
}


//   let school = try? JSONDecoder().decode(School.self, from: jsonData)

