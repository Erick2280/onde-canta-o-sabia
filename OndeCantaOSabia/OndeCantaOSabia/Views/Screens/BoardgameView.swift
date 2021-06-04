//
//  BoardgameView.swift
//  OndeCantaOSabia
//
//  Created by Erick Almeida on 02/06/21.
//

import SwiftUI

enum OverlayLayout {
    case diceRoll
    case challenge
    case trivia
    case move
    case ending
}

struct BoardgameView: View {
    
    let fromTopCoordinates: [CGFloat] = [789, 789, 789, 789, 789, 789, 789, 789, 789, 636, 484, 484, 484, 484, 484, 484, 484, 484, 331, 180, 180, 180, 180, 180, 180, 180, 180, 180]
    let fromLeadingCoordinates: [CGFloat] = [60, 364, 523, 680, 838, 995, 1153, 1310, 1467, 1467, 1467, 1310, 1153, 995, 838, 680, 523, 364, 364, 364, 523, 680, 838, 995, 1153, 1310, 1467, 1600]
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var gameState: Game
    @State var showOverlay = false
    @State var overlayLayout: OverlayLayout = .diceRoll

    @State var animateDice = false
    @State var currentDiceAnimation = "Dice1"
    @State var diceRoll: Int = 0
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    @State var currentSquareType: SquareType = .move(squares: 0)
    @State var currentTriviaQuestion: TriviaQuestion = TriviaQuestion(question: "", alternatives: ["","","",""], answer: 0)
    @State var currentChallengeCard: ChallengeCard = ChallengeCard(name: "", imageName: "OndeCantaOSabiaCard", description: "", challenge: "")
    
    @State var squaresToMove: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                Image("GameBoard")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                HStack {
                    ForEach(gameState.players, id: \.self.avatar) { player in
                        Image("\(player.avatar.rawValue)Avatar")
                            .resizable()
                            .scaledToFit()
                            .frame(height: gameState.players[gameState.nowPlaying].avatar == player.avatar ? 120 : 80)
                            .animation(.easeInOut)
                    }
                }
                
                ForEach(gameState.players, id: \.self.avatar) { player in
                    Image("\(player.avatar.rawValue)Avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .animation(.easeInOut)
                        .padding(.top, fromTopCoordinates[player.position])
                        .padding(.leading, fromLeadingCoordinates[player.position] + CGFloat(gameState.getOffsetForPlayerPosition(player: player)))
                }
                
                if (!showOverlay) {
                    Button(action: {
                        showOverlay = true
                        animateDice = true
                    }) {
                        VStack (alignment: .leading) {
                            Text("Vez de \(gameState.players[gameState.nowPlaying].avatar.rawValue)").font(.caption)
                            if (overlayLayout == .diceRoll) {
                                Text("Rodar o dado")
                            }
                            if (overlayLayout == .challenge) {
                                Text("Ver desafio")
                            }
                            if (overlayLayout == .trivia) {
                                Text("Responder trivia")
                            }
                            if (overlayLayout == .move && squaresToMove > 0) {
                                Text(squaresToMove > 1 ? "Avançar \(squaresToMove) casas" : "Avançar \(squaresToMove) casa")
                            }
                            if (overlayLayout == .move && squaresToMove < 0) {
                                Text(squaresToMove < -1 ? "Voltar \(abs(squaresToMove)) casas" : "Voltar \(abs(squaresToMove)) casa")
                            }
                            if (overlayLayout == .ending) {
                                Text("Venceu o jogo")
                            }
                        }
                    }
                    .padding(.top, 140)
                    .padding()
                }
                
                if (showOverlay) {
                    Rectangle()
                        .fill(Color.black)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .opacity(0.4)
                        .animation(.easeInOut)
                    
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).fill(Color("LightGray"))
                        .frame(width: 1100, height: 700)
                        .padding(.leading, 320)
                        .padding(.top, 170)
                        .animation(.easeInOut)
                    
                    VStack(alignment: .center) {
                        if (overlayLayout == .diceRoll) {
                            Group {
                            Text(gameState.players[gameState.nowPlaying].avatar.rawValue).font(Font.custom("Eudora", size: 32)).padding(2)
                            Text("Sua vez!").font(Font.custom("Eudora", size: 32))
                                .padding(2)
                                .padding(.bottom, 56)
                            Text("Role o dado").font(Font.custom("Eudora", size: 72))
                            Image(currentDiceAnimation)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                                .onReceive(timer) { input in
                                    if (animateDice) {
                                        currentDiceAnimation = "Dice\(gameState.rollDice())"
                                    }
                                }
                            
                            if (animateDice) {
                                Button(action: {
                                    animateDice = false
                                    diceRoll = gameState.rollDice()
                                    currentDiceAnimation = "Dice\(diceRoll)"
                                }) {
                                    Text("Rolar o dado")
                                }
                            }
                            
                            if (!animateDice) {
                                Button(action: {
                                    gameState.players[gameState.nowPlaying].position += diceRoll
                                    showOverlay = false
                                    currentSquareType = gameState.getSquareType()
                                    switch currentSquareType {
                                        case .challenge:
                                            currentChallengeCard = gameState.getChallengeCard()
                                            overlayLayout = .challenge
                                        case .trivia:
                                            currentTriviaQuestion = gameState.getTriviaQuestion()
                                            overlayLayout = .trivia
                                        case .move(let squares):
                                            squaresToMove = squares
                                            overlayLayout = .move
                                    }
                                }) {
                                    Text(diceRoll > 1 ? "Avançar \(diceRoll) casas" : "Avançar \(diceRoll) casa")
                                }
                            }
                            }
                            
                        }
                        if (overlayLayout == .challenge) {
                            Group {
                                Text("Desafio").font(Font.custom("Eudora", size: 32))
                                    .padding(2)
                                
                                HStack(alignment: .top) {
                                    Image(currentChallengeCard.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 400)
                                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                                        .padding(.bottom, 10)
                                    
                                    VStack(alignment: .center) {
                                        Text(currentChallengeCard.description)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 600, alignment: .center)
                                        Button(action: {
                                            squaresToMove = 1
                                            overlayLayout = .move
                                        }) {
                                            Text(currentChallengeCard.challenge)
                                                .frame(width: 500, alignment: .center)
                                        }
                                        Text("ou")
                                        Button(action: {
                                            squaresToMove = -2
                                            overlayLayout = .move
                                        }) {
                                            Text("Volte 2 casas")
                                                .frame(width: 500, alignment: .center)
                                        }
                                    }
                                }
                            }
                        }
                        if (overlayLayout == .trivia) {
                            Group {
                                Text("Trivia").font(Font.custom("Eudora", size: 32))
                                    .padding(2)
                                
                                Text(currentTriviaQuestion.question)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: 600, alignment: .center)
                                
                                Button(action: {
                                    if (currentTriviaQuestion.answer == 0) {
                                        squaresToMove = 2
                                    } else {
                                        squaresToMove = -2
                                    }
                                    overlayLayout = .move
                                }) {
                                    Text("a) \(currentTriviaQuestion.alternatives[0])")
                                        .frame(width: 600, alignment: .center)
                                }
                                
                                Button(action: {
                                    if (currentTriviaQuestion.answer == 1) {
                                        squaresToMove = 2
                                    } else {
                                        squaresToMove = -2
                                    }
                                    overlayLayout = .move
                                }) {
                                    Text("b) \(currentTriviaQuestion.alternatives[1])")
                                        .frame(width: 600, alignment: .center)
                                }
                                
                                Button(action: {
                                    if (currentTriviaQuestion.answer == 2) {
                                        squaresToMove = 2
                                    } else {
                                        squaresToMove = -2
                                    }
                                    overlayLayout = .move
                                }) {
                                    Text("c) \(currentTriviaQuestion.alternatives[2])")
                                        .frame(width: 600, alignment: .center)
                                }
                                
                                Button(action: {
                                    if (currentTriviaQuestion.answer == 3) {
                                        squaresToMove = 2
                                    } else {
                                        squaresToMove = -2
                                    }
                                    overlayLayout = .move
                                }) {
                                    Text("d) \(currentTriviaQuestion.alternatives[3])")
                                        .frame(width: 600, alignment: .center)
                                }
                                
                            }
                        }
                        if (overlayLayout == .move) {
                            Group {
                                if (squaresToMove < 0) {
                                    Text("Que pena!").font(Font.custom("Eudora", size: 32)).padding(24)

                                    Text("\(gameState.players[gameState.nowPlaying].avatar.rawValue),").font(Font.custom("Eudora", size: 72))
                                    
                                    Text(squaresToMove < -1 ? "Volte \(abs(squaresToMove)) casas" : "Volte \(abs(squaresToMove)) casa").font(Font.custom("Eudora", size: 72))

                                    Image("SadEmoji")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                }
                                if (squaresToMove > 0) {
                                    Text("Que tudo!").font(Font.custom("Eudora", size: 32)).padding(24)

                                    Text("\(gameState.players[gameState.nowPlaying].avatar.rawValue),").font(Font.custom("Eudora", size: 72))
                                    
                                    Text(squaresToMove > 1 ? "Avance \(squaresToMove) casas" : "Avance \(squaresToMove) casa").font(Font.custom("Eudora", size: 72))

                                    Image("HappyEmoji")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                }
                                
                                Button(action: {
                                    gameState.players[gameState.nowPlaying].position += squaresToMove
                                    
                                    if (gameState.players[gameState.nowPlaying].position < 0) {
                                        gameState.players[gameState.nowPlaying].position = 0
                                    }
                                    
                                    if (gameState.players[gameState.nowPlaying].position > 26) {
                                        overlayLayout = .ending
                                        return
                                    }
                                    
                                    gameState.goToNextPlayer()
                                    showOverlay = false
                                    overlayLayout = .diceRoll
                                }) {
                                    Text("Certo")
                                }
                                .padding(.top, 16)
                            }
                        }
                        if (overlayLayout == .ending) {
                            Text("\(gameState.players[gameState.nowPlaying].avatar.rawValue)").font(Font.custom("Eudora", size: 72))
                            
                            Text("Ganhou o jogo!").font(Font.custom("Eudora", size: 72))
                            
                            Image("HappyEmoji")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                            
                            Button(action: {
                                showOverlay = false
                            }) {
                                Text("Mostrar tabuleiro")                                    .frame(width: 600, alignment: .center)
                            }
                            .padding(.top, 16)
                            
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Sair do jogo")
                                    .frame(width: 600, alignment: .center)
                            }

                        }
                    }.frame(width: 1100, height: 700)
                    .padding(.leading, 320)
                    .padding(.top, 200)
                    .animation(.easeInOut)
                    .foregroundColor(Color("Gray"))
                
                    Image("\(gameState.players[gameState.nowPlaying].avatar)Avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 1100, height: 200, alignment: .center)
                        .padding(.leading, 320)
                        .padding(.top, 80)
                        .animation(.easeInOut)
                    
                }
                
            }
        }.font(.system(.body, design: .rounded))
    }
}

struct BoardgameView_Previews: PreviewProvider {
    static var previews: some View {
        BoardgameView(gameState: Game(amountOfPlayers: .six, players: [.Benji, .Isabella, .Juli, .Levi, .Paola, .Ryan]))
    }
}
