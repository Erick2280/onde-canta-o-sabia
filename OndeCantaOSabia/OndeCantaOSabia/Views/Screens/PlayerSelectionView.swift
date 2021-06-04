//
//  PlayerSelectionView.swift
//  OndeCantaOSabia
//
//  Created by Erick Almeida on 02/06/21.
//

import SwiftUI

struct PlayerSelectionView: View {
    
    var amountOfPlayers: AmountOfPlayers
    @State var selectedAvatars: [PlayerAvatar] = []
    @State var nowSelecting: Int = 0
    
    var body: some View {
        ZStack(alignment: .center) {
            Color("Gray")
                .ignoresSafeArea()

            VStack(alignment: .center) {
                Text("Escolha um personagem")
                    .font(Font.custom("Eudora", size: 72))
                    .padding()
                    .padding(.bottom, 48)
                VStack {
                    if (amountOfPlayers.rawValue != selectedAvatars.count) {
                        HStack {
                            ForEach(PlayerAvatar.allCases, id: \.self) { avatarName in
                                if (!selectedAvatars.contains(avatarName)) {
                                Button(action: {
                                    nowSelecting += 1
                                    selectedAvatars.append(avatarName)
                                }) {
                                    VStack(alignment: .center) {
                                        Image("\(avatarName.rawValue)Avatar")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 160, height: 160)
                                        Text(avatarName.rawValue).font(Font.custom("Eudora", size: 48))
                                        }
                                    }
                                }

                            }
                        }.padding(.bottom, 32)
                    }
                    
                    HStack {
                        ForEach(0..<amountOfPlayers.rawValue) {index in
                            VStack {
                                if (nowSelecting > index) {
                                    Image("\(selectedAvatars[index].rawValue)Avatar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 140, height: 140)
                                        .padding(.bottom, 8)
                                    Text(selectedAvatars[index].rawValue).opacity(0.6)
                                }
                                
                                if (nowSelecting == index) {
                                    Circle()
                                        .fill(Color("Brown"))
                                        .frame(width: 140, height: 140)
                                        .shadow(radius: 10, y: 10)
                                        .padding(.bottom, 8)
                                    Text("Jogador \(index + 1)")
                                }
                                
                                if (nowSelecting < index) {
                                    Circle()
                                        .fill(Color("Brown"))
                                        .frame(width: 140, height: 140)
                                        .shadow(radius: 10, y: 10)
                                        .padding(.bottom, 8)
                                    Text("Jogador \(index + 1)").opacity(0.6)
                                }
                            }
                        }
                    }.padding()
                    .padding(.bottom, 64)
                    
                    
                    if (amountOfPlayers.rawValue == selectedAvatars.count) {
                        NavigationLink(destination: BoardgameView(gameState: createGame())) {
                            Text("Jogar").font(.system(size: 48, weight: .semibold, design: .rounded))
                        }
                    }
                }
            }
        }.font(.system(.body, design: .rounded))

    }
    
    func createGame() -> Game {
        return Game(amountOfPlayers: amountOfPlayers, players: selectedAvatars)
    }
}

struct PlayerSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSelectionView(amountOfPlayers: .six)
    }
}
