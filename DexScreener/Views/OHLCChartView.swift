//
//  OHLCChartView.swift
//  DexScreener
//
//  Created by waqas on 02/08/2024.
//

import SwiftUI
import Charts

struct OHLCChartView: View {
    var ohlcData: [OHLCData] // Replace with your data model
    
    var body: some View {
        VStack {
            Text("OHLC Chart")
                .font(.headline)
            
            CandleChartView(data: ohlcData)
                .frame(height: 300)
                .padding()
        }
        .navigationTitle("OHLC Chart")
    }
}

struct CandleChartView: UIViewRepresentable {
    var data: [OHLCData] // Replace with your data model

    func makeUIView(context: Context) -> CandleStickChartView {
        let chart = CandleStickChartView()
        chart.xAxis.labelPosition = .bottom
        chart.leftAxis.axisMinimum = 0
        chart.rightAxis.enabled = false
        chart.legend.enabled = false
        return chart
    }

    func updateUIView(_ uiView: CandleStickChartView, context: Context) {
        var dataEntries: [CandleChartDataEntry] = []

        for (index, ohlc) in data.enumerated() {
            let entry = CandleChartDataEntry(x: Double(index), shadowH: ohlc.high, shadowL: ohlc.low, open: ohlc.open, close: ohlc.close)
            dataEntries.append(entry)
        }

        let dataSet = CandleChartDataSet(entries: dataEntries, label: "OHLC Data")
        dataSet.colors = [NSUIColor.blue]
        dataSet.valueTextColor = .black

        let chartData = CandleChartData(dataSet: dataSet)
        uiView.data = chartData
    }
}

struct OHLCData {
    let open: Double
    let high: Double
    let low: Double
    let close: Double
}

