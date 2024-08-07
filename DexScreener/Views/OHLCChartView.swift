import SwiftUI
import Charts

struct OHLCChartView: View {
    let tokenId: String
    @StateObject private var geckoViewModel = GeckoViewModel()
    @State private var ohlcData: [OHLCData] = []
    @State private var isLoading: Bool = true

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading OHLC Data...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        print("ProgressView is appearing, data is loading...")
                    }
            } else {
                Chart(ohlcData) { dataPoint in
                    // Candlestick representation
                    BarMark(
                        x: .value("Date", dataPoint.timestamp),
                        yStart: .value("Low", dataPoint.low),
                        yEnd: .value("High", dataPoint.high)
                    )
                    .foregroundStyle(dataPoint.close >= dataPoint.open ? Color.green : Color.red)
                    
                    BarMark(
                        x: .value("Date", dataPoint.timestamp),
                        yStart: .value("Open", dataPoint.open),
                        yEnd: .value("Close", dataPoint.close)
                    )
                    .foregroundStyle(Color.black)
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month))
                }
                .chartYAxis {
                    AxisMarks()
                }
                .onAppear {
                    print("Chart is appearing with \(ohlcData.count) data points.")
                    // Print the chart data points for debugging
                    print("OHLC Data: \(ohlcData.map { "\($0.timestamp): \($0.open) \($0.high) \($0.low) \($0.close)" })")
                }
            }
        }
        .onAppear {
            print("OHLCChartView appeared, starting data fetch for tokenId: \(tokenId).")
            fetchOHLCData()
        }
        .navigationTitle("OHLC Chart")
    }
    
    private func fetchOHLCData() {
        print("Fetching OHLC data for tokenId: \(tokenId)...")
        
        geckoViewModel.fetchOHLCData(for: tokenId) { result in
            switch result {
            case .success(let data):
                print("Successfully fetched OHLC data with \(data.count) data points.")
                // Print each data point for debugging
                data.forEach { dataPoint in
                    print("Data Point - Timestamp: \(dataPoint.timestamp), Open: \(dataPoint.open), High: \(dataPoint.high), Low: \(dataPoint.low), Close: \(dataPoint.close)")
                }
                ohlcData = data
                isLoading = false
            case .failure(let error):
                print("Failed to load OHLC data: \(error.localizedDescription)")
                isLoading = false
            }
        }
    }
}
