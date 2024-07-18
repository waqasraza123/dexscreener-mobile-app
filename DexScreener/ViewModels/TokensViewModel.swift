import Foundation

class TokensViewModel: ObservableObject {
    @Published var tokens: [Token] = []

    init() {
        fetchTokens()
    }

    func fetchTokens() {
        guard let url = URL(string: Constants.solanaApiUrl) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(TokenResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.tokens = decodedResponse.pairs
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            } else if let error = error {
                print("Failed to fetch data: \(error)")
            }
        }.resume()
    }
}
