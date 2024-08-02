import Foundation
import Combine

class GeckoViewModel: ObservableObject {
    @Published var cryptocurrencies: [GeckoToken] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var ohlcData: [OHLCData] = []

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
            .decode(type: [GeckoToken].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    print("Error details: \(error)")
                }
                self.isLoading = false
            }, receiveValue: { [weak self] cryptocurrencies in
                self?.cryptocurrencies = cryptocurrencies
            })
            .store(in: &cancellables)
    }
    
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
                let decoder = JSONDecoder()
                let fetchedData = try decoder.decode([OHLCData].self, from: data)
                DispatchQueue.main.async {
                    self.ohlcData = fetchedData
                }
            } catch {
                print("Error decoding OHLC data: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
