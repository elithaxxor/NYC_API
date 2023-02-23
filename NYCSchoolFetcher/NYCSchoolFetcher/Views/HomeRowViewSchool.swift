//
//  TableRows.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/22/23.
//

import SwiftUI

//
//  ModelRowView.swift
//  SchoolAPI
//
//  Created by Adel Al-Aali on 2/22/23.
//

import SwiftUI



// MARK: Table Structure
struct HomeRowViewSchool: View {
    // var school : Schools
    let schoolData : Schools
    
    var body: some View {
        topRow
        bottomRow
    }
}
struct HomeRowViewGrades: View {

    let gradeData : Grades

    var body: some View {
        topRow
        bottomRow
    }
}




extension HomeRowViewGrades {
    private var topRow: some View {
        HStack(spacing: 0) {
            Text("(school.dbn)")
                .font(.caption)
                .foregroundColor(.blue)
                .frame(width: 55, height: 30)
            Circle()
                .frame(width: 10, height: 10)
            
            Text("(school.schoolName")
                .font(.caption)
                .foregroundColor(.blue)
                .frame(width: 100, height: 30)
            Spacer()
        }
    }
    
    private var bottomRow: some View {
        HStack(spacing: 0) {
            Text("School info... ")
                .font(.body)
                .foregroundColor(.blue)
                .scaledToFit()
        }
        
    }
}



// MARK: Table Build
extension HomeRowViewSchool {
    private var topRow: some View {
        HStack(spacing: 0) {
            Text("(school.dbn)")
                .font(.caption)
                .foregroundColor(.blue)
                .frame(width: 55, height: 30)
            Circle()
                .frame(width: 10, height: 10)
            
            Text("(school.schoolName")
                .font(.caption)
                .foregroundColor(.blue)
                .frame(width: 100, height: 30)
            Spacer()
        }
    }
    
    private var bottomRow: some View {
        HStack(spacing: 0) {
            Text("School info... ")
                .font(.body)
                .foregroundColor(.blue)
                .scaledToFit()
        }
        
    }
}



struct TableRows_Previews: PreviewProvider  {
    static var previews: some View {
        
        HomeRowViewSchool(schoolData: Schools)
        HomeRowViewGrades(gradeData: Grades)
        // HomeRowView(coin: Schools)
        
    }
}
