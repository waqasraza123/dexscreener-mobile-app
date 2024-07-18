import SwiftUI

struct TokensView: View {
    @ObservedObject var viewModel: TokensViewModel

    init(viewModel: TokensViewModel = TokensViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...") // Show loading indicator
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            ForEach(viewModel.tokens) { token in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(token.baseToken.symbol) / \(token.quoteToken.symbol)")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Spacer()
                                        Text("Price: \(token.priceUsd)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    Divider()
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("24h Volume")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                            Text("\(token.volume.h24, specifier: "%.2f")")
                                                .font(.body)
                                        }
                                        Spacer()
                                        VStack(alignment: .leading) {
                                            Text("Transactions (Last 24h)")
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                            HStack {
                                                Text("Buys: \(token.txns.h24.buys)")
                                                    .font(.body)
                                                Text("Sells: \(token.txns.h24.sells)")
                                                    .font(.body)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("Tokens")
            .onAppear {
                viewModel.fetchTokens()
            }
        }
    }
}

struct TokensView_Previews: PreviewProvider {
    static var previews: some View {
        TokensView()
    }
}
