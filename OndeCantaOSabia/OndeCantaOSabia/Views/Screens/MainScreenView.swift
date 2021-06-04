//
//  MainScreenView.swift
//  OndeCantaOSabia
//
//  Created by Erick Almeida on 02/06/21.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Image("MainScreenBackground")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Image("Logo").padding(.bottom, 48)
                        HStack {
                            NavigationLink(destination: AmountOfPlayersView()) {
                                Text("Nova partida")
                            }
                            
                            NavigationLink(destination: HowToPlayView()) {
                                Text("Como jogar")
                            }
                        }.font(.system(size: 48, weight: .semibold, design: .rounded))
                    }
                }
            }
        }
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
