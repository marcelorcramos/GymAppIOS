import SwiftUI

struct ExerciciosListView: View {
    @EnvironmentObject var viewModel: ExerciciosViewModel
    @State private var mostrarAdicionarExercicio = false
    @State private var pesquisa = ""
    
    var exerciciosFiltrados: [Exercicio] {
        if pesquisa.isEmpty {
            return viewModel.exercicios
        } else {
            return viewModel.exercicios.filter {
                $0.nome.localizedCaseInsensitiveContains(pesquisa) ||
                $0.musculo.localizedCaseInsensitiveContains(pesquisa)
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(exerciciosFiltrados) { exercicio in
                ExercicioRowView(exercicio: exercicio)
            }
            .onDelete(perform: viewModel.removerExercicio)
        }
        .searchable(text: $pesquisa, prompt: "Buscar exercício ou músculo")
        .navigationTitle("Meus Treinos")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    mostrarAdicionarExercicio = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .bold))
                }
            }
        }
        .sheet(isPresented: $mostrarAdicionarExercicio) {
            AdicionarExercicioView()
        }
    }
}
