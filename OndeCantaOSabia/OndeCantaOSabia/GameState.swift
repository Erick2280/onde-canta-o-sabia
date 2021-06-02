//
//  GameState.swift
//  OndeCantaOSabia
//
//  Created by Erick Almeida on 02/06/21.
//

import Foundation

public enum AmountOfPlayers: Int {
    case three = 3
    case four = 4
    case five = 5
    case six = 6
}

public enum PlayerAvatar: String {
    case Isabella
    case Benji
    case Juli
    case Paola
    case Levi
    case Ryan
}

public class Game {
    let challengeCards: [ChallengeCard] = [
        ChallengeCard(
            name: "Boto Cor-de-Rosa",
            imageName: "BotoCorDeRosaCard",
            description: "O boto cor-de-rosa se transforma num belo homem para atrair as mulheres com seu charme.",
            challenge: "Dê uma cantada em alguém"),
        ChallengeCard(
            name: "Saci-Pererê",
            imageName: "SaciPerereCard",
            description: "O Saci é um menino travesso que possui apenas uma perna, fuma cachimbo e carrega uma carapuça vermelha que lhe concede poderes mágicos.",
            challenge: "Dê 10 pulinhos de uma perna só"),
        ChallengeCard(
            name: "Saci-Pererê",
            imageName: "SaciPerereCard",
            description: "O Saci é um menino travesso que possui apenas uma perna, fuma cachimbo e carrega uma carapuça vermelha que lhe concede poderes mágicos.",
            challenge: "Faça uma trança no cabelo de alguém (se não souber, seja criativo)"),
        ChallengeCard(
            name: "Iara",
            imageName: "IaraCard",
            description: "Com sua voz, a sereia Iara seduz pescadores desavisados no Rio Amazonas que, encantados pela voz da sereia, pulam no rio e se afogam.",
            challenge: "Cante uma música"),
        ChallengeCard(
            name: "Comadre Fulozinha",
            imageName: "ComadreFulozinhaCard",
            description: "Muitas vezes confundida com a Caipora, a Comadre Fulozinha protege as florestas e assusta quem sai pela mata sem deixar-lhe uma oferenda.",
            challenge: "Chegue perto de uma planta e fale 3x \"Comadre Fulozinha\"."),
        ChallengeCard(
            name: "Loira do Banheiro",
            imageName: "LoiraDoBanheiroCard",
            description: "A Loira do Banheiro costuma assombrar pelo outro lado do espelho. Ela assombra os banheiros brasileiros desde o século XIX.",
            challenge: "Abra a câmera do celular e chame 3x a Loira do Banheiro"),
        ChallengeCard(
            name: "Curupira",
            imageName: "CurupiraCard",
            description: "Protetor das florestas, o curupira possui cabelos vermelhos e pés virados para trás. Engana caçadores que pretendem o seguir olhando suas pegadas.",
            challenge: "Deixe um outro jogador te guiar enquanto você anda de costas"),
        ChallengeCard(
            name: "Boitatá",
            imageName: "BoitataCard",
            description: "O Boitatá e uma cobra de fogo gigante que protege as florestas brasileiras. Vive nos rios e se transforma em fogo para amedrontar quem queima a floresta.",
            challenge: "Imite uma cobra"),
        ChallengeCard(
            name: "*",
            imageName: "OndeCantaOSabiaCard",
            description: "",
            challenge: "Faça mímica de um personagem do folclore à sua escolha"),
        ChallengeCard(
            name: "*",
            imageName: "OndeCantaOSabiaCard",
            description: "",
            challenge: "Improvise um relato sobre uma experiência com alguma lenda do folclore brasileiro")

    ]
    let triviaQuestions: [TriviaQuestion] = [
        TriviaQuestion(
            question: "De acordo com a lenda, quando uma mulher se relaciona com um padre ela se torna...",
            alternatives: ["Curupira", "Boitatá", "Mula sem cabeça", "Mapinguari"],
            answer: 2),
        TriviaQuestion(
            question: "De acordo com os pernambucanos, de onde é o maior São João do país?",
            alternatives: ["Caruaru", "Campina Grande", "Surubim", "Garanhuns"],
            answer: 0),
        TriviaQuestion(
            question: "Qual personagem do folclore brasileiro virou meme nas redes sociais?",
            alternatives: ["Saci", "Cuca", "Iara", "Corpo-seco"],
            answer: 1),
        TriviaQuestion(
            question: "Em que região surgiu a lenda do Saci Pererê?",
            alternatives: ["Norte", "Nordeste", "Sudeste", "Sul"],
            answer: 3),
        TriviaQuestion(
            question: "Com quantos paus se faz uma canoa?",
            alternatives: ["1", "2", "3", "4"],
            answer: 0),
        TriviaQuestion(
            question: "Quem é o homem mais ignorante do mundo?",
            alternatives: ["Seu Lunga", "Bino", "Antônio Fagundes", "Patativa do Assaré"],
            answer: 0),
        TriviaQuestion(
            question: "Em que década surgiu a lenda da perna cabeluda na cidade do Recife?",
            alternatives: ["40", "50", "60", "70"],
            answer: 3),
        TriviaQuestion(
            question: "Quem nasce em Bacurau é...",
            alternatives: ["Bacuralense", "Gente", "Pessoa", "Bacurense"],
            answer: 1),
        TriviaQuestion(
            question: "Qual foi a primeira capital de Pernambuco?",
            alternatives: ["Recife", "Jaboatão dos Guararapes", "Olinda", "Itamaracá"],
            answer: 2),
        TriviaQuestion(
            question: "A mentira mais contada no carnaval é...",
            alternatives: ["Olinda é vazia no sábado do Galo", "Recife Antigo é ruim à noite", "\"Eu aguento Olinda de manhã e Antigo à noite SIM\"", "\"A gente se encontra lá, pô\""],
            answer: 0),
        TriviaQuestion(
            question: "Qual desses artistas não é nordestino?",
            alternatives: ["Ivete Sangalo", "Pixinguinha", "Luiz Gonzaga", "Alceu Valença"],
            answer: 1),
        TriviaQuestion(
            question: "Qual dessas invenções não é brasileira?",
            alternatives: ["Escorredor de Arroz", "Radiografia do pulmão", "Fogão à gás", "Avião"],
            answer: 2),
        TriviaQuestion(
            question: "Complete: A La Ursa quer dinheiro, quem não dá é...",
            alternatives: ["muito feio", "sem coração", "pirangueiro", "mão de vaca"],
            answer: 2)
    ]
    
    let amountOfPlayers: AmountOfPlayers
    var players: [Player]
    var nowPlaying: Int
    
    public init (amountOfPlayers: AmountOfPlayers, players: [PlayerAvatar]) {
        self.amountOfPlayers = amountOfPlayers
        self.players = []
        self.nowPlaying = 0
        for playerAvatar in players {
            let player = Player(avatar: playerAvatar)
            self.players.append(player)
        }
    }
    
    public func goToNextPlayer() {
        self.nowPlaying = self.nowPlaying + 1 % self.amountOfPlayers.rawValue
    }
    
    public func rollDice() -> Int {
        let diceRoll = Int.random(in: 1...6)
        players[nowPlaying].position += diceRoll
        return diceRoll;
    }
    
    public func getTriviaQuestion() -> TriviaQuestion {
        let randomNumber = Int.random(in: 0..<triviaQuestions.count)
        return self.triviaQuestions[randomNumber]
    }
    
    public func getChallengeCard() -> ChallengeCard {
        let randomNumber = Int.random(in: 0..<challengeCards.count)
        return self.challengeCards[randomNumber]
    }
    
    public func getSquareType() -> SquareType {
        let randomNumber = Int.random(in: 0...9)
        
        if (randomNumber >= 0 && randomNumber < 6) {
            return SquareType.Trivia
        }
        
        if (randomNumber >= 6 && randomNumber < 9) {
            return SquareType.Challenge
        }
        
        
        let moveRandomNumber = Int.random(in: -3...3)
        return SquareType.Move(squares: moveRandomNumber)
    }
    
}

public class Player {
    public let avatar: PlayerAvatar
    public var position: Int
    
    public init(avatar: PlayerAvatar) {
        self.avatar = avatar
        self.position = 0
    }
}

public struct ChallengeCard {
    let name: String
    let imageName: String
    let description: String
    let challenge: String
}

public struct TriviaQuestion {
    let question: String
    let alternatives: [String]
    let answer: Int
}

public enum SquareType {
    case Challenge
    case Trivia
    case Move(squares: Int)
}
