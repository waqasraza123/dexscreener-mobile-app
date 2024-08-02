import SwiftUI

struct Top100CryptocurrenciesView: View {
    @StateObject private var viewModel = GeckoViewModel()
    @State private var selectedCrypto: GeckoToken?
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...") // Show loading indicator
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.cryptocurrencies) { crypto in
                        NavigationLink(value: crypto) {
                            HStack {
                                HStack {
                                    AsyncImage(url: URL(string: crypto.image)) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        case .failure(_):
                                            Image(systemName: "photo") // Fallback image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 30, height: 30)
                                                .clipShape(Circle())
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    
                                    Text(crypto.symbol.uppercased())
                                }
                                .frame(width: 120, alignment: .leading)
                                
                                Text("$\(crypto.current_price, specifier: "%.2f")")
                                    .frame(width: 100, alignment: .trailing)
                                
                                Text(formattedMarketCap(crypto.market_cap))
                                    .frame(width: 130, alignment: .trailing)
                            }
                            .padding(.vertical, 5)
                        }
                        .tag(crypto) // Use tag for navigation to match the selectedCrypto
                    }
                    .navigationTitle("Top 100+ Tokens")
                }
            }
            .onAppear {
                viewModel.fetchCryptocurrencies()
            }
            .navigationDestination(for: GeckoToken.self) { crypto in
                OHLCChartView(tokenId: crypto.id)
            }
        }
    }
}
