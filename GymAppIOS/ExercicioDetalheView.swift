import SwiftUI

struct ExercicioDetalheView: View {
    let exercicio: Exercicio
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                cabeçalhoView
                detalhesView
                Button("Marcar como Concluído") {
                    // Lógica para marcar exercício como concluído
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .padding()
        }
        .navigationTitle(exercicio.nome)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var cabeçalhoView: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(corDoMusculo(exercicio.musculo))
                    .frame(width: 100, height: 100)
                
                Image(systemName: iconeDoMusculo(exercicio.musculo))
                    .font(.system(size: 50))
                    .foregroundColor(.white)
            }
            
            Text(exercicio.musculo)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 8)
        }
    }
    
    var detalhesView: some View {
        VStack(spacing: 20) {
            cartaoDetalhe(titulo: "Máquina", valor: exercicio.maquina, icone: "dumbbell.fill")
            cartaoDetalhe(titulo: "Repetições", valor: "\(exercicio.repeticoes)", icone: "repeat")
            cartaoDetalhe(titulo: "Tempo", valor: formatarTempo(exercicio.tempo), icone: "clock")
            cartaoDetalhe(titulo: "Data", valor: formatarData(exercicio.data), icone: "calendar")
        }
    }
    
    func cartaoDetalhe(titulo: String, valor: String, icone: String) -> some View {
        HStack {
            Image(systemName: icone)
                .font(.system(size: 20))
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(titulo)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(valor)
                    .font(.title3)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
    
    func iconeDoMusculo(_ musculo: String) -> String {
        switch musculo {
        case "Peitoral": return "figure.arms.open"
        case "Costas": return "figure.mixed.cardio"
        case "Pernas": return "figure.walk"
        case "Braços": return "figure.boxing"
        case "Abdômen": return "figure.core.training"
        case "Ombros": return "figure.strengthtraining.traditional"
        case "Glúteos": return "figure.run"
        case "Panturrilha": return "figure.run.circle"
        default: return "figure.highintensity.intervaltraining"
        }
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
    
    func formatarData(_ data: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: data)
    }
    
    func formatarTempo(_ segundos: Int) -> String {
        let minutos = segundos / 60
        let segundosRestantes = segundos % 60
        return "\(minutos)m \(segundosRestantes)s"
    }
}
