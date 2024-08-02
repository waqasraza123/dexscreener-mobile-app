import SwiftUI
import Charts

struct OHLCChartView: View {
    let ohlcData: [OHLCData]

    var body: some View {
        VStack {
            Chart(data: ohlcData) { dataPoint in
                LineMark(
                    x: .value("Date", dataPoint.date),
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

struct OHLCData {
    let date: Date
    let open: Double
    let high: Double
    let low: Double
    let close: Double
}