//
//  UIColor+Extension.swift
//  Scorecard
//
//  Mostly stolen from: https://medium.com/ios-os-x-development/ios-extend-uicolor-with-custom-colors-93366ae148e6
//
//

import UIKit

extension UIColor {
    convenience init( red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff,
                  green:(netHex >> 8) & 0xff,
                  blue:netHex & 0xff)
    }
}

extension UIColor {
    struct ScorecardTheme {
        static let Red = UIColor(netHex: 0xED424A)
        static let Blue = UIColor(netHex: 0x37BDF2)
        static let Green = UIColor(netHex: 0x91F271)
        static let Yellow = UIColor(netHex: 0xFFC45E)
        static let Purple = UIColor(netHex: 0x79609E)
    }
}
