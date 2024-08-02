import Foundation
import Combine

class GeckoViewModel: ObservableObject {
    @Published var cryptocurrencies: [GeckoToken] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func fetchCryptocurrencies() {
        isLoading = true

        let endpoint = "/gecko/coins-list-with-market-data"
        guard let url = URL(string: Constants.apiUrl + endpoint) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                // Print raw data for debugging
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Raw JSON Data: \(jsonString)")
//                }
            })
            .decode(type: [GeckoToken].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Handle specific errors and update the errorMessage
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    print("Error details: \(error)")
                }
                self.isLoading = false
            }, receiveValue: { [weak self] cryptocurrencies in
                self?.cryptocurrencies = cryptocurrencies
            })
            .store(in: &cancellables)
    }
}
