import SwiftUI

struct TokensView: View {
    @ObservedObject var viewModel: TokensViewModel

    init(viewModel: TokensViewModel = TokensViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.tokens) { token in
                        VStack(alignment: .leading) {
                            Text("\(token.baseToken.symbol) / \(token.quoteToken.symbol)")
                                .font(.headline)
                            Text("Price: \(token.priceUsd)")
                            Text("24h Volume: \(token.volume.h24)")
                            Text("Transactions (Last 24h):")
                            Text("  Buys: \(token.txns.h24.buys)")
                            Text("  Sells: \(token.txns.h24.sells)")
                        }
                        .padding()
                        Divider() // Add a divider between tokens for better separation
                    }
                }
                .padding()
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
