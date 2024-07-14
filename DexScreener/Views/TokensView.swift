//
//  TokensView.swift
//  DexScreener
//
//  Created by Waqas on 7/14/24.
//



import SwiftUI

struct TokensView: View {
    @ObservedObject var viewModel: TokensViewModel = TokensViewModel()

    var body: some View {
        List(viewModel.tokens) { token in
            TokenRow(token: token)
        }
        .navigationBarTitle("Tokens")
    }
}

struct TokenRow: View {
    var token: Token

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(token.name)
                    .font(.headline)
                Text("Price: $\(token.price)")
                Text("Txns: \(token.transactions)")
                Text("24h V: $\(token.volume24h)")
            }
            .padding(.vertical, 8)

            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

struct TokensView_Previews: PreviewProvider {
    static var previews: some View {
        TokensView()
    }
}
