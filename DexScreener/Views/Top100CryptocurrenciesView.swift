import SwiftUI

struct Top100CryptocurrenciesView: View {
    @StateObject private var viewModel = GeckoViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...") // Show loading indicator
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.cryptocurrencies) { crypto in
                        HStack {
                            AsyncImage(url: URL(string: crypto.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(crypto.name)
                                    .font(.headline)
                                Text("Symbol: \(crypto.symbol.uppercased())")
                                    .font(.subheadline)
                                Text("Price: $\(crypto.current_price, specifier: "%.2f")")
                                    .font(.body)
                                Text("Market Cap: $\(crypto.market_cap, specifier: "%.2f")")
                                    .font(.body)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("Top 100+ Cryptocurrencies")
            .onAppear {
                viewModel.fetchCryptocurrencies()
            }
        }
    }
}

struct Top100CryptocurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        Top100CryptocurrenciesView()
    }
}
