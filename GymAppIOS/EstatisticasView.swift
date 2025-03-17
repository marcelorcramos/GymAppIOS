import SwiftUI
import Charts

struct EstatisticasView: View {
    @EnvironmentObject var viewModel: ExerciciosViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                cartaoEstatisticas
                graficoMusculosPizza
                exerciciosPorMusculo
            }
            .padding()
        }
        .navigationTitle("Estatísticas")
    }
    
    var cartaoEstatisticas: some View {
        VStack(spacing: 15) {
            HStack {
                estatisticaItem(
                    valor: "\(viewModel.exercicios.count)",
                    titulo: "Total de\nExercícios",
                    cor: .blue,
                    icone: "figure.highintensity.intervaltraining"
                )
                
                Spacer()
                
                estatisticaItem(
                    valor: "\(Set(viewModel.exercicios.map { $0.musculo }).count)",
                    titulo: "Grupos\nMusculares",
                    cor: .green,
                    icone: "chart.pie.fill"
                )
            }
            
            HStack {
                estatisticaItem(
                    valor: tempoTotalFormatado(),
                    titulo: "Tempo\nTotal",
                    cor: .orange,
                    icone: "clock.fill"
                )
                
                Spacer()
                
                estatisticaItem(
                    valor: "\(viewModel.exercicios.reduce(0) { $0 + $1.repeticoes })",
                    titulo: "Total de\nRepetições",
                    cor: .purple,
                    icone: "repeat.circle.fill"
                )
            }
        }
    }
    
    var graficoMusculosPizza: some View {
        VStack(alignment: .leading) {
            Text("Distribuição de Músculos")
                .font(.headline)
                .padding(.bottom, 5)
            
            if #available(iOS 16.0, *) {
                Chart(viewModel.obterDadosDoGrafico()) { item in
                    SectorMark(
                        angle: .value("Quantidade", item.quantidade),
                        innerRadius: .ratio(0.6),
                        angularInset: 1.5
                    )
                    .cornerRadius(5)
                    .foregroundStyle(by: .value("Músculo", item.nome))
                }
                .frame(height: 250)
            } else {
                // Fallback para iOS 15 ou anterior
                pieChartFallback()
            }
            
            legendaGrafico()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    func pieChartFallback() -> some View {
        let dados = viewModel.obterDadosDoGrafico()
        let total = dados.reduce(0) { $0 + $1.quantidade }
        
        return ZStack {
            ForEach(0..<dados.count, id: \.self) { index in
                Circle()
                    .trim(from: proporçãoCumulativa(até: index, dados: dados),
                          to: proporçãoCumulativa(até: index + 1, dados: dados))
                    .stroke(corDoMusculo(dados[index].nome), lineWidth: 30)
                    .frame(width: 200, height: 200)
                    .rotationEffect(.degrees(-90))
            }
            
            Circle()
                .fill(Color(.systemBackground))
                .frame(width: 120, height: 120)
            
            Text("\(total)\nExercícios")
                .font(.system(.headline, design: .rounded))
                .multilineTextAlignment(.center)
        }
        .frame(height: 250)
    }
    
    func proporçãoCumulativa(até index: Int, dados: [MusculoData]) -> Double {
        let total = Double(dados.reduce(0) { $0 + $1.quantidade })
        var soma = 0
        
        for i in 0..<index {
            soma += dados[i].quantidade
        }
        
        return Double(soma) / total
    }
    
    func legendaGrafico() -> some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
            ForEach(viewModel.obterDadosDoGrafico()) { item in
                HStack {
                    Circle()
                        .fill(corDoMusculo(item.nome))
                        .frame(width: 12, height: 12)
                    
                    Text(item.nome)
                        .font(.caption)
                    
                    Spacer()
                    
                    Text("\(item.quantidade)")
                        .font(.caption)
                        .fontWeight(.bold)
                }
                .padding(.vertical, 2)
            }
        }
    }
    
    var exerciciosPorMusculo: some View {
        VStack(alignment: .leading) {
            Text("Exercícios por Músculo")
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(viewModel.obterDadosDoGrafico().sorted(by: { $0.quantidade > $1.quantidade })) { item in
                HStack {
                    Text(item.nome)
                    
                    Spacer()
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(.systemGray5))
                            .frame(width: 200, height: 20)
                            .cornerRadius(5)
                        
                        Rectangle()
                            .fill(corDoMusculo(item.nome))
                            .frame(width: proporcao(item), height: 20)
                            .cornerRadius(5)
                        
                        Text("\(item.quantidade)")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.leading, 5)
                    }
                }
                .padding(.bottom, 5)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    func proporcao(_ item: MusculoData) -> CGFloat {
        let maximo = viewModel.obterDadosDoGrafico().map { $0.quantidade }.max() ?? 1
        return CGFloat(item.quantidade) / CGFloat(maximo) * 200
    }
    
    func estatisticaItem(valor: String, titulo: String, cor: Color, icone: String) -> some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(cor.opacity(0.2))
                    .frame(width: 160, height: 100)
                
                VStack {
                    Image(systemName: icone)
                        .font(.system(size: 22))
                        .foregroundColor(cor)
                    
                    Text(valor)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .padding(.vertical, 2)
                    
                    Text(titulo)
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    func tempoTotalFormatado() -> String {
        let totalSegundos = viewModel.exercicios.reduce(0) { $0 + $1.tempo }
        let minutos = totalSegundos / 60
        
        if minutos >= 60 {
            let horas = minutos / 60
            return "\(horas)h"
        } else {
            return "\(minutos)m"
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
}
