import SwiftUI

struct AdicionarExercicioView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ExerciciosViewModel
    
    @State private var nome = ""
    @State private var maquina = ""
    @State private var repeticoes = 10
    @State private var tempo = 60
    @State private var musculo = "Peitoral"
    
    let musculos = ["Peitoral", "Costas", "Pernas", "Braços", "Abdômen", "Ombros", "Glúteos", "Panturrilha"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Detalhes do Exercício")) {
                    TextField("Nome do exercício", text: $nome)
                        .autocapitalization(.words)
                    
                    TextField("Máquina utilizada", text: $maquina)
                        .autocapitalization(.words)
                    
                    VStack(alignment: .leading) {
                        Text("Repetições: \(repeticoes)")
                        Slider(value: Binding(
                            get: { Double(repeticoes) },
                            set: { repeticoes = Int($0) }
                        ), in: 1...30, step: 1)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Tempo: \(formatarTempo(tempo))")
                        Slider(value: Binding(
                            get: { Double(tempo) },
                            set: { tempo = Int($0) }
                        ), in: 30...300, step: 10)
                    }
                }
                
                Section(header: Text("Grupo Muscular")) {
                    Picker("Músculo", selection: $musculo) {
                        ForEach(musculos, id: \.self) { musculo in
                            HStack {
                                Circle()
                                    .fill(corDoMusculo(musculo))
                                    .frame(width: 20, height: 20)
                                Text(musculo)
                            }
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                }
            }
            .navigationTitle("Novo Exercício")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        viewModel.adicionarExercicio(
                            nome: nome,
                            maquina: maquina,
                            repeticoes: repeticoes,
                            tempo: tempo,
                            musculo: musculo
                        )
                        dismiss()
                    }
                    .bold()
                    .disabled(nome.isEmpty || maquina.isEmpty)
                }
            }
        }
    }
    
    func formatarTempo(_ segundos: Int) -> String {
        let minutos = segundos / 60
        let segundosRestantes = segundos % 60
        return "\(minutos)m \(segundosRestantes)s"
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
