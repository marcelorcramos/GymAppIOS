import SwiftUI
import Charts

struct ProgressoView: View {
    @State private var peso: [Double] = [70.0, 69.5, 69.0, 68.8, 68.2, 67.9, 67.5]
    @State private var datas: [Date] = (0..<7).map { Calendar.current.date(byAdding: .day, value: -$0, to: Date())! }.reversed()
    @State private var metricaSelecionada = "Peso"
    
    let metricas = ["Peso", "IMC", "Gordura Corporal", "Massa Muscular"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Cabeçalho
                VStack(alignment: .leading, spacing: 8) {
                    Text("Acompanhamento de Progresso")
                        .font(.headline)
                    
                    Text("Monitore suas métricas e veja sua evolução ao longo do tempo")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                // Seletor de métrica
                Picker("Métrica", selection: $metricaSelecionada) {
                    ForEach(metricas, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // Gráfico
                VStack {
                    if #available(iOS 16.0, *) {
                        Chart {
                            ForEach(0..<datas.count, id: \.self) { index in
                                LineMark(
                                    x: .value("Data", datas[index]),
                                    y: .value("Valor", peso[index])
                                )
                                .foregroundStyle(Color.blue.gradient)
                                
                                PointMark(
                                    x: .value("Data", datas[index]),
                                    y: .value("Valor", peso[index])
                                )
                                .foregroundStyle(Color.blue)
                            }
                        }
                        .frame(height: 220)
                        .padding()
                    } else {
                        graficoFallback()
                    }
                }
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Tendência
                HStack {
                    VStack(alignment: .leading) {
                        Text("Tendência")
                            .font(.headline)
                        
                        Text("↓ Diminuindo")
                            .foregroundColor(.green)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Variação")
                            .font(.headline)
                        
                        Text("-3.6%")
                            .foregroundColor(.green)
                            .font(.subheadline)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Tabela de dados
                VStack(alignment: .leading, spacing: 10) {
                    Text("Histórico de \(metricaSelecionada)")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ForEach(0..<datas.count, id: \.self) { index in
                        HStack {
                            Text(formatarData(datas[index]))
                                .font(.subheadline)
                            
                            Spacer()
                            
                            Text(String(format: "%.1f kg", peso[index]))
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                        .padding(.vertical, 8)
                        
                        if index < datas.count - 1 {
                            Divider()
                        }
                    }
                    
                    Button(action: {
                        // Lógica para adicionar novo registro
                    }) {
                        Label("Adicionar novo registro", systemImage: "plus")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Progresso")
    }
    
    func graficoFallback() -> some View {
        HStack(alignment: .bottom, spacing: 15) {
            ForEach(0..<datas.count, id: \.self) { index in
                VStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 30, height: CGFloat(peso[index]) * 2)
                    
                    Text(formatarData(datas[index], formato: "dd/MM"))
                        .font(.caption)
                        .rotationEffect(.degrees(-45))
                        .frame(width: 30)
                }
            }
        }
        .frame(height: 220)
        .padding()
    }
    
    func formatarData(_ data: Date, formato: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formato
        return formatter.string(from: data)
    }
}

