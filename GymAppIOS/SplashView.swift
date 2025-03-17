import SwiftUI

struct SplashView: View {
    @State private var escalaLogo = 0.5
    @State private var opacidadeLogo = 0.3
    @State private var mostrarMain = false
    
    var body: some View {
        if mostrarMain {
            MainTabView()
        } else {
            ZStack {
                Color("PrimaryColor")
                    .ignoresSafeArea()
                
                VStack {
                    Image(systemName: "dumbbell.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .scaleEffect(escalaLogo)
                        .opacity(opacidadeLogo)
                    
                    Text("GymTracker Pro")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                        .opacity(opacidadeLogo)
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.5)) {
                    escalaLogo = 1.0
                    opacidadeLogo = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        mostrarMain = true
                    }
                }
            }
        }
    }
}
