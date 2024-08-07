import SwiftUI

struct Top100CryptocurrenciesView: View {
    @StateObject private var viewModel = GeckoViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.cryptocurrencies) { crypto in
                        NavigationLink(destination: OHLCChartView(tokenId: crypto.id)) {
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
                                        Image(systemName: "photo")
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
                                    .frame(width: 100, alignment: .leading)
                                
                                Text("$\(crypto.current_price, specifier: "%.2f")")
                                    .frame(width: 90, alignment: .trailing)
                                
                                Text(formattedMarketCap(crypto.market_cap))
                                    .frame(width: 110, alignment: .trailing)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .navigationTitle("Top 100+ Tokens")
                }
            }
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
