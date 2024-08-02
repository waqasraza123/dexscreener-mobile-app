import Foundation

func formattedMarketCap(_ value: Double) -> String {
    let absValue = abs(value)
    
    if absValue >= 1_000_000_000_000 {
        return String(format: "$%.2f T", value / 1_000_000_000_000)
    } else if absValue >= 1_000_000_000 {
        return String(format: "$%.2f B", value / 1_000_000_000)
    } else if absValue >= 1_000_000 {
        return String(format: "$%.2f M", value / 1_000_000)
    } else {
        return String(format: "$%.2f", value)
    }
}
