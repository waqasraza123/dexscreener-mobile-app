import SwiftUI

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
            } else {
//                OHLCChartRepresentable(data: ohlcData)
//                    .frame(height: 300)
            }
        }
        .onAppear {
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
                ohlcData = data
                isLoading = false
            case .failure(let error):
                print("Failed to load OHLC data: \(error.localizedDescription)")
                isLoading = false
            }
        }
    }
}
