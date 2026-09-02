//
//  ImageExt.swift
//  PokeSharedUI
//
//  Created by Hector Climaco on 30/07/26.
//

import Foundation
import SwiftUI

public extension Image {

    // Inicializador específico para AssetImages
    init(asset: AssetImages) {
        let bundle = Bundle(for: AssetHelper.self)
        self.init(asset.rawValue, bundle: bundle)
    }
}


public class AssetHelper {
    // Clase de marcador de posición para obtener el bundle correcto
}
