import SwiftUI

struct PerfilView: View {
    @State private var nome = "Usuário"
    @State private var altura = 175
    @State private var peso = 70.0
    @State private var idade = 30
    @State private var objetivos = "Ganho de massa muscular"
    @State private var editando = false
    
    var imc: Double {
        let alturaMetros = Double(altura) / 100.0
        return peso / (alturaMetros * alturaMetros)
    }
    
    var categoriaIMC: String {
        switch imc {
        case ..<18.5: return "Abaixo do peso"
        case 18.5..<25: return "Peso normal"
        case 25..<30: return "Sobrepeso"
        case 30..<35: return "Obesidade Grau I"
        case 35..<40: return "Obesidade Grau II"
        default: return "Obesidade Grau III"
        }
    }
    
    var corIMC: Color {
        switch imc {
        case ..<18.5: return .orange
        case 18.5..<25: return .green
        case 25..<30: return .yellow
        default: return .red
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                perfilHeader
                
                if editando {
                    formularioEdicao
                } else {
                    informacaoPerfil
                }
            }
            .padding()
        }
        .navigationTitle("Meu Perfil")
        .toolbar {
            Button(editando ? "Salvar" : "Editar") {
                withAnimation {
                    editando.toggle()
                }
            }
        }
    }
    
    var perfilHeader: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.bottom, 10)
            
            Text(nome)
                .font(.title)
                .fontWeight(.bold)
        }
    }
    
    var informacaoPerfil: some View {
        VStack(spacing: 15) {
            // Medidas corporais
            Group {
                HStack {
                    infoCard(titulo: "Altura", valor: "\(altura) cm", icone: "ruler", cor: .blue)
                    infoCard(titulo: "Peso", valor: String(format: "%.1f kg", peso), icone: "scalemass", cor: .green)
                }
                
                HStack {
                    infoCard(titulo: "Idade", valor: "\(idade) anos", icone: "calendar", cor: .orange)
                    infoCard(titulo: "IMC", valor: String(format: "%.1f", imc), icone: "heart.text.square", cor: corIMC)
                }
            }
            
            // Status do IMC
            HStack {
                Text("Status do IMC:")
                    .font(.headline)
                
                Text(categoriaIMC)
                    .font(.headline)
                    .foregroundColor(corIMC)
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            // Objetivos
            VStack(alignment: .leading, spacing: 8) {
                Text("Meus Objetivos")
                    .font(.headline)
                
                Text(objetivos)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            // Botões de ações
            Group {
                Button(action: {
                    // Lógica para compartilhar progresso
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Compartilhar Progresso")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    // Lógica para exportar dados
                }) {
                    HStack {
                        Image(systemName: "arrow.down.doc")
                        Text("Exportar Dados")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                Button(action: {
                    // Lógica para visualizar histórico
                }) {
                    HStack {
                        Image(systemName: "chart.xyaxis.line")
                        Text("Visualizar Histórico")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
    
    var formularioEdicao: some View {
        VStack(spacing: 15) {
            Group {
                TextField("Nome", text: $nome)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Stepper("Altura: \(altura) cm", value: $altura, in: 100...250)
                
                HStack {
                    Text("Peso: \(String(format: "%.1f kg", peso))")
                    Slider(value: $peso, in: 30...200, step: 0.5)
                }
                
                Stepper("Idade: \(idade) anos", value: $idade, in: 1...120)
                
                TextField("Objetivos", text: $objetivos)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
    
    func infoCard(titulo: String, valor: String, icone: String, cor: Color) -> some View {
        VStack {
            Image(systemName: icone)
                .font(.title)
                .foregroundColor(cor)
            
            Text(titulo)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text(valor)
                .font(.headline)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// Preview para verificar a interface no Canvas
struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PerfilView()
        }
    }
}
