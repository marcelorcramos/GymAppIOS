import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = ExerciciosViewModel()
    
    var body: some View {
        TabView {
            NavigationView {
                ExerciciosListView()
            }
            .tabItem {
                Label("Exercícios", systemImage: "figure.highintensity.intervaltraining")
            }
            
            NavigationView {
                EstatisticasView()
            }
            .tabItem {
                Label("Estatísticas", systemImage: "chart.pie.fill")
            }
            
            NavigationView {
                PerfilView()
            }
            .tabItem {
                Label("Perfil", systemImage: "person.fill")
            }
        }
        .accentColor(UIColor(named: "AccentColor") != nil ? Color("AccentColor") : Color.blue)
        .environmentObject(viewModel)
    }
}
