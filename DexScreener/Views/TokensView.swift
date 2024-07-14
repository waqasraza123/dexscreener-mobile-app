import SwiftUI

struct TokensView: View {
    @State private var tokens: [Token] = [
        Token(name: "Bitcoin", price: 34000.0, transactions: 1500, volume24h: 500000.0),
        Token(name: "Ethereum", price: 2100.0, transactions: 2500, volume24h: 300000.0),
        Token(name: "Litecoin", price: 150.0, transactions: 500, volume24h: 20000.0)
    ]

    var body: some View {
        NavigationView {
            List(tokens) { token in
                TokenRow(token: token)
            }
            .navigationBarTitle("Tokens")
        }
    }
}

struct TokenRow: View {
    var token: Token

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(token.name)
                    .font(.headline)
                Text("Price: \(token.price)")
                Text("Txns: \(token.transactions)")
                Text("24h V: \(token.volume24h)")
            }
            Spacer()
        }
        .padding()
    }
}

struct TokensView_Previews: PreviewProvider {
    static var previews: some View {
        TokensView()
    }
}
