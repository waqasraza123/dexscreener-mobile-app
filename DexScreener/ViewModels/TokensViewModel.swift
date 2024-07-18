import SwiftUI

class TokensViewModel: ObservableObject {
    @Published var tokens: [Token] = []
    @Published var isLoading: Bool = false // Track loading state

    init() {
        fetchTokens()
    }

    func fetchTokens() {
        isLoading = true // Start loading
        guard let url = URL(string: Constants.solanaApiUrl) else {
            print("Invalid URL")
            isLoading = false // Stop loading if URL is invalid
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    print(data)
                    let decodedResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.tokens = decodedResponse.pairs
                        self.isLoading = false // Stop loading when data is fetched
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                    DispatchQueue.main.async {
                        self.isLoading = false // Stop loading if there's an error
                    }
                }
            } else if let error = error {
                print("Failed to fetch data: \(error)")
                DispatchQueue.main.async {
                    self.isLoading = false // Stop loading if there's an error
                }
            }
        }.resume()
    }
}
