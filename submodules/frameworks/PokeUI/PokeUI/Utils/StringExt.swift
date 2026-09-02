//
//  StringExt.swift
//  PokeUI
//
//  Created by Hector Climaco on 30/07/26.
//

import Foundation

extension Int {
    func toIdFormat() -> String {
        return "#" + String(format: "%03d", self)
    }
}
