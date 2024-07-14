//
//  TokensViewModel.swift
//  DexScreener
//
//  Created by Waqas on 7/14/24.
//

import Foundation


class TokensViewModel: ObservableObject {
    @Published var tokens: [Token] = []

    init() {
        // Dummy data (replace with API call)
        tokens = [
            Token(name: "Bitcoin", price: 34000.0, transactions: 1500, volume24h: 500000.0),
            Token(name: "Ethereum", price: 2100.0, transactions: 2500, volume24h: 300000.0),
            Token(name: "Cardano", price: 1.5, transactions: 800, volume24h: 10000.0),
            Token(name: "Solana", price: 35.0, transactions: 1200, volume24h: 80000.0)
        ]
    }
}
