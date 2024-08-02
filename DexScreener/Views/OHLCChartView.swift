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
                ProgressView("Loading OHLC Data...") // Show loading indicator
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Chart(ohlcData) { dataPoint in
                    LineMark(
                        x: .value("Date", dataPoint.timestamp),
                        y: .value("Price", dataPoint.close)
                    )
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month))
                }
                .chartYAxis {
                    AxisMarks()
                }
            }
        }
        .onAppear {
            fetchOHLCData()
        }
        .navigationTitle("OHLC Chart")
    }
    
    private func fetchOHLCData() {
        geckoViewModel.fetchOHLCData(for: tokenId) { result in
            switch result {
            case .success(let data):
                ohlcData = data
                isLoading = false
            case .failure(let error):
                print("Failed to load OHLC data: \(error)")
                isLoading = false
            }
        }
    }

}
