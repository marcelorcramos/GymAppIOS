import Foundation

struct Exercicio: Identifiable, Codable {
    let id = UUID()
    var nome: String
    var maquina: String
    var repeticoes: Int
    var tempo: Int // em segundos
    var musculo: String
    var data: Date
}

struct MusculoData: Identifiable {
    let id = UUID()
    let nome: String
    let quantidade: Int
}
