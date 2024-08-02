//
//  OHLCData.swift
//  DexScreener
//
//  Created by waqas on 02/08/2024.
//

import Foundation

struct OHLCData: Identifiable, Decodable {
    var id = UUID()
    let timestamp: Date
    let open: Double
    let high: Double
    let low: Double
    let close: Double
}
