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
                    VStack {
                        // Table Header
                        HStack {
                            Text("ID")
                                .frame(width: 120, alignment: .leading)
                                .font(.headline)
                            Text("Price")
                                .frame(width: 100, alignment: .trailing)
                                .font(.headline)
                            Text("MC")
                                .frame(width: 120, alignment: .trailing)
                                .font(.headline)
                        }
                        .padding(.bottom, 5)
                        
                        // Table Data
                        ScrollView {
                            VStack(alignment: .leading) {
                                ForEach(viewModel.cryptocurrencies) { crypto in
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
                                    .onTapGesture {
                                        viewModel.fetchOHLCData(for: crypto.id)
                                        selectedCrypto = crypto // Store the selected crypto
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Top 100+ Tokens")
            .onAppear {
                viewModel.fetchCryptocurrencies()
            }
            .navigationDestination(for: GeckoToken.self) { crypto in
                if selectedCrypto != nil {
                    OHLCChartView(ohlcData: viewModel.ohlcData)
                } else {
                    EmptyView()
                }
            }
        }
    }
}

struct Top100CryptocurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        Top100CryptocurrenciesView()
    }
}
