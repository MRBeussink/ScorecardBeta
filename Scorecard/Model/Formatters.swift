//
//  Formatters.swift
//  Scorecard
//
//  Created by Mark Beussink on 20180106.
//  Copyright © 2018 Mark Beussink. All rights reserved.
//

import Foundation

func formatString(from date: Date) -> String {
    return dateFormatter.string(from: date)
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateStyle = .medium
    return formatter
}()

func formatPercent(from decimal: NSDecimalNumber) -> String {
    return percentFormatter.string(from: decimal)!
}

let percentFormatter: NumberFormatter = {
    var formatter = NumberFormatter()
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 3
    formatter.numberStyle = .percent
    return formatter
}()
