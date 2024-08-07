//import SwiftUI
//import DGCharts
//
//struct OHLCChartRepresentable: UIViewRepresentable {
//    let data: [OHLCData]
//
//    func makeUIView(context: Context) -> CandleStickChartView {
//        let chartView = CandleStickChartView()
//        configureChartView(chartView)
//        return chartView
//    }
//
//    func updateUIView(_ uiView: CandleStickChartView, context: Context) {
//        let entries = data.map { entry in
//            CandleChartDataEntry(
//                x: entry.timestamp.timeIntervalSince1970,
//                shadowH: entry.high,
//                shadowL: entry.low,
//                open: entry.open,
//                close: entry.close
//            )
//        }
//
//        let dataSet = CandleChartDataSet(entries: entries, label: "OHLC Data")
//        configureDataSet(dataSet)
//        
//        let chartData = CandleChartData(dataSet: dataSet)
//        uiView.data = chartData
//    }
//
//    private func configureChartView(_ chartView: CandleStickChartView) {
//        chartView.chartDescription.enabled = false
//        chartView.dragEnabled = false
//        chartView.setScaleEnabled(true)
//        chartView.maxVisibleCount = 200
//        chartView.pinchZoomEnabled = true
//        
//        chartView.legend.horizontalAlignment = .right
//        chartView.legend.verticalAlignment = .top
//        chartView.legend.orientation = .vertical
//        chartView.legend.drawInside = false
//        chartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
//        
//        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
//        chartView.leftAxis.spaceTop = 0.3
//        chartView.leftAxis.spaceBottom = 0.3
//        chartView.leftAxis.axisMinimum = 0
//        
//        chartView.rightAxis.enabled = false
//        
//        chartView.xAxis.labelPosition = .bottom
//        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
//    }
//
//    private func configureDataSet(_ dataSet: CandleChartDataSet) {
//        dataSet.axisDependency = .left
//        dataSet.setColor(UIColor(white: 80/255, alpha: 1))
//        dataSet.drawIconsEnabled = false
//        dataSet.shadowColor = .darkGray
//        dataSet.shadowWidth = 0.7
//        dataSet.decreasingColor = .red
//        dataSet.decreasingFilled = true
//        dataSet.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
//        dataSet.increasingFilled = false
//        dataSet.neutralColor = .blue
//    }
//}
