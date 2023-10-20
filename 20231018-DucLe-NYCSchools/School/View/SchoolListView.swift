//
//  SchoolListView.swift
//  20231018-DucLe-NYCSchools
//
//  Created by Duc Le on 10/21/23.
//

import SwiftUI

struct SchoolListView: View {
    @StateObject private var viewModel = SchoolListViewModel()
    @StateObject private var scoreModel = ScoreListViewModel()
    @State private var selectedSchool: School?
    
    var body: some View {
        NavigationView {
            List(viewModel.schools) { school in
                Text(school.schoolName)
                    .accessibilityIdentifier("schoolCell_\(school.id ?? "")") // Set unique identifier for each cell

                    .onTapGesture {
                        selectedSchool = school
                    }
            }
            .navigationBarTitle("Schools List")
            .accessibilityIdentifier("schoolListTable")
        }
        .sheet(item: $selectedSchool) { school in
            ScoreListView(scoreModel: scoreModel, school: school)
        }
        .onAppear {
            viewModel.fetchSchools()
        }
    }
}
