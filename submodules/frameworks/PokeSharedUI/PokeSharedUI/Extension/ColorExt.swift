//
//  ColorExt.swift
//  PokeSharedUI
//
//  Created by Hector Climaco on 30/07/26.
//

import SwiftUI

public extension Color {

    init(_ color: AssetColors) {
        let bundle = Bundle(for: AssetHelper.self)
        self.init(color.rawValue, bundle: bundle)
    }
    
    init(color: AssetColors) {
        let bundle = Bundle(for: AssetHelper.self)
        self.init(color.rawValue, bundle: bundle)
    }
    
    init(colorAssetName: String) {
        let bundle = Bundle(for: AssetHelper.self)
        self.init(colorAssetName, bundle: bundle)
    }
    
}
