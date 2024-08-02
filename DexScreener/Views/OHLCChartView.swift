import SwiftUI
import Charts

struct OHLCChartView: View {
    let ohlcData: [OHLCData]

    var body: some View {
        VStack {
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
}
