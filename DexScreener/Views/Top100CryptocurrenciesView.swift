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
                                            AsyncImage(url: URL(string: crypto.image)) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 30, height: 30)
                                            } placeholder: {
                                                ProgressView()
                                                    .frame(width: 30, height: 30)
                                            }
                                            .clipShape(Circle())
                                            
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
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Top 100+ Tokens")
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
