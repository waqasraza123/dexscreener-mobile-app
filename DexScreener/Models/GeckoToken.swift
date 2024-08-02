struct GeckoToken: Identifiable, Codable, Hashable, Equatable {
    var id: String
    var symbol: String
    var name: String
    var image: String
    var current_price: Double
    var market_cap: Double
    var market_cap_rank: Int
    var fully_diluted_valuation: Double?
    var total_volume: Double
    var high_24h: Double
    var low_24h: Double
    var price_change_24h: Double
    var price_change_percentage_24h: Double
    var market_cap_change_24h: Double
    var market_cap_change_percentage_24h: Double
    var circulating_supply: Double
    var total_supply: Double?
    var max_supply: Double?
    var ath: Double
    var ath_change_percentage: Double
    var ath_date: String
    var atl: Double
    var atl_change_percentage: Double
    var atl_date: String
    var roi: ROI?
    var last_updated: String

    struct ROI: Codable {
        var times: Double
        var currency: String
        var percentage: Double
    }
    
    // Conformance to Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Conformance to Equatable
    static func == (lhs: GeckoToken, rhs: GeckoToken) -> Bool {
        return lhs.id == rhs.id
    }
}
