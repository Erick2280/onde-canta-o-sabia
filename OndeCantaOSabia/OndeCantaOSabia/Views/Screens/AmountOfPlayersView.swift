//
//  AmountOfPlayersView.swift
//  OndeCantaOSabia
//
//  Created by Erick Almeida on 02/06/21.
//

import SwiftUI

struct AmountOfPlayersView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color("Gray")
                .ignoresSafeArea()

            VStack(alignment: .center) {
                Text("Quantidade de jogadores")
                    .font(Font.custom("Eudora", size: 72))
                    .padding()
                    .padding(.bottom, 48)
                HStack {
                    NavigationLink(destination: PlayerSelectionView(amountOfPlayers: .three)) {
                        Text("3").font(.system(size: 128, weight: .semibold, design: .rounded))
                    }
                    NavigationLink(destination: PlayerSelectionView(amountOfPlayers: .four)) {
                        Text("4").font(.system(size: 128, weight: .semibold, design: .rounded))
                    }
                    NavigationLink(destination: PlayerSelectionView(amountOfPlayers: .five)) {
                        Text("5").font(.system(size: 128, weight: .semibold, design: .rounded))
                    }
                    NavigationLink(destination: PlayerSelectionView(amountOfPlayers: .six)) {
                        Text("6").font(.system(size: 128, weight: .semibold, design: .rounded))
                    }
                }.padding(.vertical, 192)
            }
        }
    }
}

struct AmountOfPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        AmountOfPlayersView()
    }
}
