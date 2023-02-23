//
//  HomeView.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import SwiftUI
import Combine

// MARK: Home UI Build
struct HomeView: View {
    @State private var showIndex: Bool = false
    @State private var showAboutMe: Bool = false
    
    @State private var showSchools: Bool = false
    @State private var showGrades: Bool = false
    
    
    // MARK: Use to access school info / grades
    @EnvironmentObject private var schoolVM : SchoolViewModel
    @EnvironmentObject private var gradesVM : GradesViewModel
    
    fileprivate var runAPI = APIManager()
    
    var body: some View {
        header
        Divider()
        if !showSchools {
            homeBody
        }
        footerBtn
        
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
            //        FooterView()
            //            .previewLayout(.fixed(width: 375, height: 80))
            //
            
        }
        .environmentObject(SchoolViewModel())
        .environmentObject(GradesViewModel())
    }
}




// MARK: Home UI Components
extension HomeView {
    
    
    // MARK: Body of home view, uses data UI build from HomeRowView component
    private var homeBody : some View {
        // background layer
        ZStack {
            // Color.background(.gray)
            
            // Content layer
            VStack {
                List {
                    ForEach(schoolVM.schools) { sch in
                        HomeRowViewSchool(schoolData: sch)
                            .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    }
     
                }
                .listStyle(PlainListStyle())
                .transition(.move(edge: .leading))
                Spacer(minLength: 0)
                

            }
            
        }
    }
    
    
    
    
    private var header : some View {
        // MARK: Header
        ZStack {
            VStack{
                HStack {
                    CircleButton(iconView: "info")
                        .animation(.none)
                    
                    /// Sets up background animation for circle
                        .background(
                            CircleButtonAnimationView(animate: $showAboutMe)
                        )
                    Spacer()
                    
                    
                    // showIndex boolean value to change header text
                    Text(showIndex ? "parsed data.." : "NYC API Fetcher ")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                // TODO: ADD SEGUE TO ABOUT ME POPUP
                                showAboutMe.toggle()
                                
                            }
                        }
                    Spacer()
                    CircleButton(iconView: "heart")
                        .background(
                            CircleButtonAnimationView(animate: $showIndex)
                        )
                        .onTapGesture {
                            withAnimation(.spring()) {
                                // TODO: ADD FETCH FUCNTION
                                APIManager.shared.fetchSchoolData()
                                showIndex = true
                            }
                        }
                }
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
        }
    }
    
    private var footerBtn : some View {
        // MARK: Footer
        HStack {
            VStack {
                ZStack{
                    FooterView()
                }
            }
        }
    }
}
