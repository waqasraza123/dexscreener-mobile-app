import Foundation
import Combine

class GeckoViewModel: ObservableObject {
    @Published var cryptocurrencies: [GeckoToken] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    // fetch list of token from coingecko api
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
    
    // fetch ohlc (open, high, low, close) values for the token from coingecko api
    func fetchOHLCData(for tokenId: String) {
        let endpoint = "/gecko/ohlc-chart-data/\(tokenId)"
        guard let url = URL(string: Constants.apiUrl + endpoint) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching OHLC data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let ohlcData = try JSONSerialization.jsonObject(with: data, options: [])
                print("OHLC Data for \(tokenId): \(ohlcData)")
            } catch {
                print("Error decoding OHLC data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
