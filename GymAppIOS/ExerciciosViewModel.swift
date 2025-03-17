import SwiftUI

class ExerciciosViewModel: ObservableObject {
    @Published var exercicios: [Exercicio] = [] {
        didSet {
            salvarExercicios()
        }
    }
    
    init() {
        carregarExercicios()
    }
    
    func adicionarExercicio(nome: String, maquina: String, repeticoes: Int, tempo: Int, musculo: String) {
        let novoExercicio = Exercicio(nome: nome, maquina: maquina, repeticoes: repeticoes, tempo: tempo, musculo: musculo, data: Date())
        exercicios.append(novoExercicio)
    }
    
    func removerExercicio(at indexSet: IndexSet) {
        exercicios.remove(atOffsets: indexSet)
    }
    
    func salvarExercicios() {
        if let encoded = try? JSONEncoder().encode(exercicios) {
            UserDefaults.standard.set(encoded, forKey: "exerciciosSalvos")
        }
    }
    
    func carregarExercicios() {
        if let exerciciosSalvos = UserDefaults.standard.data(forKey: "exerciciosSalvos") {
            if let decodedExercicios = try? JSONDecoder().decode([Exercicio].self, from: exerciciosSalvos) {
                exercicios = decodedExercicios
                return
            }
        }
        // Dados de exemplo
        exercicios = [
            Exercicio(nome: "Supino", maquina: "Banco reto", repeticoes: 12, tempo: 120, musculo: "Peitoral", data: Date()),
            Exercicio(nome: "Agachamento", maquina: "Barra livre", repeticoes: 10, tempo: 180, musculo: "Pernas", data: Date()),
            Exercicio(nome: "Puxada frontal", maquina: "Máquina de pulley", repeticoes: 15, tempo: 90, musculo: "Costas", data: Date())
        ]
    }
    
    func obterDadosDoGrafico() -> [MusculoData] {
        var dadosAgrupados: [String: Int] = [:]
        
        for exercicio in exercicios {
            if let valor = dadosAgrupados[exercicio.musculo] {
                dadosAgrupados[exercicio.musculo] = valor + 1
            } else {
                dadosAgrupados[exercicio.musculo] = 1
            }
        }
        
        return dadosAgrupados.map { MusculoData(nome: $0.key, quantidade: $0.value) }
    }
}
