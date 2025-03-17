import SwiftUI

struct ExercicioRowView: View {
    let exercicio: Exercicio
    
    var body: some View {
        NavigationLink(destination: ExercicioDetalheView(exercicio: exercicio)) {
            HStack(spacing: 15) {
                ZStack {
                    Circle()
                        .fill(corDoMusculo(exercicio.musculo))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: iconeDoMusculo(exercicio.musculo))
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(exercicio.nome)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(exercicio.musculo)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Label("\(exercicio.repeticoes) reps", systemImage: "repeat")
                            .font(.caption)
                        
                        Text("•")
                        
                        Label(formatarTempo(exercicio.tempo), systemImage: "clock")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(formatarData(exercicio.data))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 8)
        }
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
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: data)
    }
    
    func formatarTempo(_ segundos: Int) -> String {
        let minutos = segundos / 60
        return "\(minutos)min"
    }
}
