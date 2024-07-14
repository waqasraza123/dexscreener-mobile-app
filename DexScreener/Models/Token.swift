import Foundation

struct Token: Identifiable {
    var id = UUID()
    var name: String
    var price: Double
    var transactions: Int
    var volume24h: Double
}
