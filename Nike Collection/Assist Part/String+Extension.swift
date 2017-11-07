//
//  String+Extension.swift
//  Nike Collection
//
//  Created by Shao Kahn on 11/3/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

extension String {
    func stripFileExtension() -> String {
        if self.contains(".") {
            
            // example: "Jordan.jpg" to "Jordan"
return self.substring(to: self.characters.index(of: ".")!)
            
        }
        return self
    }
}
