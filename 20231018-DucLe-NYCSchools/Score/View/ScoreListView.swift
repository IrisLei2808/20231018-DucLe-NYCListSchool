//
//  ScoreListView.swift
//  20231018-DucLe-NYCSchools
//
//  Created by Duc Le on 10/21/23.
//

import SwiftUI

struct ScoreListView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var scoreModel: ScoreListViewModel
    var school: School
    
    var body: some View {
        VStack {
            Text(school.schoolName)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            if let satScores = scoreModel.satScores {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Math: \(satScores.satMathAvgScore)")
                    Text("Reading: \(satScores.satCriticalReadingAvgScore)")
                    Text("Writing: \(satScores.satWritingAvgScore)")
                }
                .padding()
            } else if let error = scoreModel.error {
                Text("Error: \(error)")
                    .padding()
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back to List")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear {
            scoreModel.fetchSatScores(forDBN: school.id ?? "")
        }
    }
}
