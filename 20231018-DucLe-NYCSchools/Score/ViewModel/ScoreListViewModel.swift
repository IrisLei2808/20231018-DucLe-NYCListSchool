//
//  ScoreListViewModel.swift
//  20231018-DucLe-NYCSchools
//
//  Created by Duc Le on 10/21/23.
//

import Foundation
import Combine

class ScoreListViewModel: ObservableObject {
    @Published var satScores: Score?
    @Published var error: String?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func fetchSatScores(forDBN dbn: String) {
        guard let url = URL(string: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json?dbn=\(dbn)") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                print("data")
                return data
            }
            .map { data in
                print(String(data: data, encoding: .utf8) ?? "")
                return data
            }
            .decode(type: [Score].self, decoder: JSONDecoder())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.error = error.localizedDescription
                    }
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] satScores in
                DispatchQueue.main.async {
                    self?.satScores = satScores.first
                }
            })
            .store(in: &cancellables)
    }
}
