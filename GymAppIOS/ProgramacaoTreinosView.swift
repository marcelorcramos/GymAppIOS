import SwiftUI

struct ProgramacaoTreinosView: View {
    @State private var diaSelecionado = "Segunda"
    let diasSemana = ["Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado", "Domingo"]
    @State private var mostrarAdicionarTreino = false
    
    // Exemplo de dados de programação de treinos
    @State private var programacao: [String: [String]] = [
        "Segunda": ["Peitoral", "Tríceps"],
        "Terça": ["Costas", "Bíceps"],
        "Quarta": ["Pernas"],
        "Quinta": ["Ombros", "Abdômen"],
        "Sexta": ["Peitoral", "Tríceps"],
        "Sábado": ["Costas", "Bíceps"],
        "Domingo": ["Descanso"]
    ]
    
    var body: some View {
        VStack {
            // Seletor de dia
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(diasSemana, id: \.self) { dia in
                        Button(action: {
                            diaSelecionado = dia
                        }) {
                            Text(dia.prefix(3))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                                .background(diaSelecionado == dia ? Color.blue : Color(.systemGray5))
                                .foregroundColor(diaSelecionado == dia ? .white : .primary)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            
            // Conteúdo do treino
            List {
                Section(header: Text("Treino de \(diaSelecionado)")) {
                    if let treinos = programacao[diaSelecionado], !treinos[0].contains("Descanso") {
                        ForEach(treinos, id: \.self) { grupo in
                            HStack {
                                Circle()
                                    .fill(corDoMusculo(grupo))
                                    .frame(width: 12, height: 12)
                                
                                Text(grupo)
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                        Button(action: {
                            mostrarAdicionarTreino = true
                        }) {
                            Label("Adicionar grupo muscular", systemImage: "plus")
                        }
                    } else {
                        Text("Dia de descanso")
                            .foregroundColor(.secondary)
                        
                        Button(action: {
                            mostrarAdicionarTreino = true
                        }) {
                            Label("Planejar treino", systemImage: "plus")
                        }
                    }
                }
                
                Section(header: Text("Notas")) {
                    Text("Lembre-se de hidratar durante o treino e realizar alongamentos após cada sessão.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle("Programação de Treinos")
        .sheet(isPresented: $mostrarAdicionarTreino) {
            AdicionarTreinoView(diaSelecionado: diaSelecionado, programacao: $programacao)
        }
    }
    
    func corDoMusculo(_ musculo: String) -> Color {
        switch musculo {
        case "Peitoral": return .red
        case "Costas": return .blue
        case "Pernas": return .green
        case "Braços", "Bíceps", "Tríceps": return .orange
        case "Abdômen": return .purple
        case "Ombros": return .pink
        case "Glúteos": return .yellow
        case "Panturrilha": return .teal
        default: return .gray
        }
    }
}
