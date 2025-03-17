import SwiftUI

struct AdicionarTreinoView: View {
    @Environment(\.dismiss) var dismiss
    let diaSelecionado: String
    @Binding var programacao: [String: [String]]
    @State private var grupoSelecionado = "Peitoral"
    
    let gruposMusculares = ["Peitoral", "Costas", "Pernas", "Braços", "Bíceps", "Tríceps", "Abdômen", "Ombros", "Glúteos", "Panturrilha", "Descanso"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Adicionar Treino")) {
                    Picker("Grupo Muscular", selection: $grupoSelecionado) {
                        ForEach(gruposMusculares, id: \.self) { grupo in
                            Text(grupo)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                if grupoSelecionado != "Descanso" {
                    Section(header: Text("Exercícios Sugeridos")) {
                        ForEach(exerciciosSugeridos(para: grupoSelecionado), id: \.self) { exercicio in
                            HStack {
                                Text(exercicio)
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Treino de \(diaSelecionado)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        if grupoSelecionado == "Descanso" {
                            programacao[diaSelecionado] = ["Descanso"]
                        } else {
                            if var treinos = programacao[diaSelecionado] {
                                if treinos.first == "Descanso" {
                                    treinos = [grupoSelecionado]
                                } else if !treinos.contains(grupoSelecionado) {
                                    treinos.append(grupoSelecionado)
                                }
                                programacao[diaSelecionado] = treinos
                            } else {
                                programacao[diaSelecionado] = [grupoSelecionado]
                            }
                        }
                        dismiss()
                    }
                    .bold()
                }
            }
        }
    }
    
    func exerciciosSugeridos(para grupo: String) -> [String] {
        switch grupo {
        case "Peitoral":
            return ["Supino Reto", "Supino Inclinado", "Crucifixo", "Crossover"]
        case "Costas":
            return ["Puxada Frontal", "Remada Curvada", "Pulldown", "Remada Baixa"]
        case "Pernas":
            return ["Agachamento", "Leg Press", "Cadeira Extensora", "Stiff"]
        case "Braços", "Bíceps":
            return ["Rosca Direta", "Rosca Alternada", "Martelo", "Concentrada"]
        case "Tríceps":
            return ["Tríceps Corda", "Tríceps Francês", "Tríceps Testa", "Mergulho"]
        case "Abdômen":
            return ["Abdominal Supra", "Prancha", "Abdominal Infra", "Oblíquos"]
        case "Ombros":
            return ["Desenvolvimento", "Elevação Lateral", "Elevação Frontal", "Encolhimento"]
        case "Glúteos":
            return ["Agachamento Sumo", "Elevação Pélvica", "Abdução de Quadril", "Avanço"]
        case "Panturrilha":
            return ["Panturrilha em Pé", "Panturrilha Sentado", "Elevação de Calcanhares", "Saltos"]
        default:
            return []
        }
    }
}
