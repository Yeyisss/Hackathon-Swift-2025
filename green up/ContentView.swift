//
//  ContentView.swift
//  green up
//
//  Created by Alumno on 27/03/25.
//

import SwiftUI

struct ContentView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo con degradado
                LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    
                    Spacer()
                    
                    Text("GREEN")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                        .padding(.bottom, 20)
                        .padding(.top, 55)

                    Spacer()
                    
                    Text("UP")
                        .font(.system(size: 70, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                        .padding(.bottom, 20)
                    
                    // Logo de la app
                    Image(systemName: "leaf.arrow.triangle.circlepath")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200) // Tamaño cuadrado para mejor simetría
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(rotation), anchor: .center) // Rotar desde el centro
                        .onAppear {
                            withAnimation(Animation.linear(duration: 4).repeatForever(autoreverses: false)) {
                                rotation = 360 // Rotación infinita
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) // Mantener en el centro
                    
                    Spacer()
                    
                    Text("Tu ruta al reciclaje está cerca")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .shadow(color: .black, radius: 5, x: 5, y: 5)
                        .padding(.bottom, 20)

                    // Botón que lleva a la pantalla "Inicio"
                    NavigationLink(destination: Inicio()) {
                        Text("Iniciar")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white.opacity(8))
                            .padding()
                            .background(Color.green)
                            .cornerRadius(80)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
