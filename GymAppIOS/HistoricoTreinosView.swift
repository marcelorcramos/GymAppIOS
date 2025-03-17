import SwiftUI

struct HistoricoTreinosView: View {
    @EnvironmentObject var viewModel: ExerciciosViewModel
    @State private var periodoSelecionado = "Semana"
    let periodos = ["Semana", "Mês", "Ano"]
    
    var exerciciosAgrupados: [Date: [Exercicio]] {
        let calendario = Calendar.current
        var agrupados: [Date: [Exercicio]] = [:]
        
        for exercicio in viewModel.exercicios {
            let componentes: Set<Calendar.Component> = [.year, .month, .day]
            let dataChave = calendario.date(from: calendario.dateComponents(componentes, from: exercicio.data))!
            
            if var existentes = agrupados[dataChave] {
                existentes.append(exercicio)
                agrupados[dataChave] = existentes
            } else {
                agrupados[dataChave] = [exercicio]
            }
        }
        
        return agrupados
    }
    
    var body: some View {
        VStack {
            Picker("Período", selection: $periodoSelecionado) {
                ForEach(periodos, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            List {
                ForEach(exerciciosAgrupados.keys.sorted(), id: \.self) { data in
                    Section(header: Text(formatarData(data))) {
                        ForEach(exerciciosAgrupados[data]!) { exercicio in
                            HStack {
                                Circle()
                                    .fill(corDoMusculo(exercicio.musculo))
                                    .frame(width: 12, height: 12)
                                
                                Text(exercicio.nome)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Text("\(exercicio.repeticoes) reps")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Histórico de Treinos")
    }
    
    func formatarData(_ data: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: data)
    }
    
    func corDoMusculo(_ musculo: String) -> Color {
        switch musculo {
        case "Peitoral": return .red
        case "Costas": return .blue
        case "Pernas": return .green
        case "Braços": return .orange
        case "Abdômen": return .purple
        case "Ombros": return .pink
        case "Glúteos": return .yellow
        case "Panturrilha": return .teal
        default: return .gray
        }
    }
}

