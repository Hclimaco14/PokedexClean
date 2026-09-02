//
//  LaunchScreenView.swift
//  PokeUI
//
//  Created by Hector Climaco on 30/07/26.
//

import SwiftUI
import PokeSharedUI

struct LaunchScreenView: View {
    var body: some View {
        VStack{
            logo
        }.background(
            Color(color: .DarkBlue)
        )
    }
    
    var logo: some View {
        VStack{
            Spacer()
            Image(asset: .pokemonLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    LaunchScreenView()
}
