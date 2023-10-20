//
//  SchoolListViewModel.swift
//  20231018-DucLe-NYCSchools
//
//  Created by Duc Le on 10/21/23.
//

import Foundation
import Combine

class SchoolListViewModel: ObservableObject {
    @Published var schools: [School] = []
    private let listSchoolUrl = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchSchools() {
        guard let url = URL(string: listSchoolUrl) else {
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [School].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] schools in
                self?.schools = schools
            })
            .store(in: &cancellables)
    }
}
