//
//  Double+Extension.swift
//  Nike Collection
//
//  Created by Bobby Negoat on 11/9/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

extension Double {
    var currencyFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))!
    }
}
