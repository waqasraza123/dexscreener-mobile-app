import Foundation

struct TokenResponse: Decodable {
    var pairs: [Token]
}

struct Token: Identifiable, Decodable {
    var id: String {
        baseToken.address
    }
    var baseToken: TokenDetails
    var quoteToken: TokenDetails
    var priceUsd: String
    var txns: Txns
    var volume: Volume
    var priceChange: PriceChange
    var liquidity: Liquidity
}

struct TokenDetails: Decodable {
    var address: String
    var name: String
    var symbol: String
}

struct Txns: Decodable {
    var m5: TxnDetails
    var h1: TxnDetails
    var h6: TxnDetails
    var h24: TxnDetails
}

struct TxnDetails: Decodable {
    var buys: Int
    var sells: Int
}

struct Volume: Decodable {
    var h24: Double
    var h6: Double
    var h1: Double
    var m5: Double
}

struct PriceChange: Decodable {
    var m5: Double
    var h1: Double
    var h6: Double
    var h24: Double
}

struct Liquidity: Decodable {
    var usd: Double
    var base: Double
    var quote: Double
}
