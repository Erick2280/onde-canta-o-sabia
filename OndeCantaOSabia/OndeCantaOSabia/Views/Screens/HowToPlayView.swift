//
//  HowToPlayView.swift
//  OndeCantaOSabia
//
//  Created by Erick Almeida on 02/06/21.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
            ZStack(alignment: .center) {
                Color("Gray")
                    .ignoresSafeArea()

                VStack(alignment: .leading) {
                    Text("Como jogar")
                        .font(Font.custom("Eudora", size: 72))
                        .padding()
                        .padding(.bottom, 48)
                    Text("Onde Canta O Sabiá é um party game que envolve lendas locais e cultura brasileira.").padding(8)
                    Text("O objetivo é chegar ao final do tabuleiro, mas para isso os jogadores precisarão responder questões a respeito do folclore brasileiro ou cumprir desafios intrigantes.").padding(8)
                    Text("O primeiro a chegar ao final do tabuleiro vence!").padding(8)
                }
                .multilineTextAlignment(.leading)
                .font(.system(size: 48, weight: .medium, design: .rounded))
                .frame(width: 1200)
        }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
