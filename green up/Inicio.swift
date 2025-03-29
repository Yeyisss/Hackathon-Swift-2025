//
//  Inicio.swift
//  green up
//
//  Created by Alumno on 28/03/25.
//

import SwiftUI

struct Inicio: View {
    @State private var currentSelection: String? = nil // esto sirve para saber qué botón se seleccionó
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Inicio")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding(.leading, 20)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 20)
                
                // Mensaje de bienvenida
                // Este mensaje dará la bienvenida al usuario y le proporcionará información sobre la aplicación.
                Text("¡Bienvenido a Green Up! Aprende cómo cuidar el medio ambiente a través de 3 prácticas clave: Reciclar, Reutilizar y Reducir.")
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .foregroundColor(.white)
                

                // Botones expandibles con la información
                BotonExpandible(titulo: "Reciclar", descripcion: "Reciclar significa procesar materiales ya usados para hacer nuevos productos, reduciendo la necesidad de materias primas nuevas.", currentSelection: $currentSelection)
                
                BotonExpandible(titulo: "Reutilizar", descripcion: "Reutilizar es el acto de usar algo varias veces antes de desecharlo, como usar frascos o bolsas más de una vez.", currentSelection: $currentSelection)
                
                BotonExpandible(titulo: "Reducir", descripcion: "Reducir significa disminuir el consumo de productos y energía, así como la cantidad de desechos generados.", currentSelection: $currentSelection)
                
                Spacer()
            }
            .padding()
            .background(
                // Fondo con degradado
                LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .onTapGesture {
                // Se oculta la info. al presionar fuera de los botones
                withAnimation {
                    currentSelection = nil
                }
            }
            
            // nav bar
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            //acción para "inicio"
                        }) {
                            VStack {
                                Image(systemName: "house.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.green)
                                Text("Inicio")
                                    .font(.footnote)
                                    .foregroundColor(.green)
                            }
                            .padding()
                        }
                        Spacer()
                        
                        NavigationLink(destination: Mapa()){
                            VStack {
                                Image(systemName: "map.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.green)
                                Text("Mapa")
                                    .font(.footnote)
                                    .foregroundColor(.green)
                            }
                            .padding()
                        }
                        Spacer()
                        
                        NavigationLink(destination: _R()){
                            VStack {
                                Image(systemName: "arrow.3.trianglepath")
                                    .font(.system(size: 30))
                                    .foregroundColor(.green)
                                Text("3R")
                                    .font(.footnote)
                                    .foregroundColor(.green)
                            }
                            .padding()
                        }
                        Spacer()
                        
                        NavigationLink(destination: Perfil()) {
                            VStack {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.green)
                                Text("Perfil")
                                    .font(.footnote)
                                    .foregroundColor(.green)
                                }
                                .padding()
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(height: 70)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 10)
                }
                    .padding()
                , alignment: .bottom
            )
        }
    }
}

struct BotonExpandible: View {
    let titulo: String // Título del botón
    let descripcion: String // Descripción que se muestra al dar click al botón
    @Binding var currentSelection: String? // Estado compartido para rastrear la selección
    
    var body: some View {
        Button(action: {
            withAnimation {
                // Alterna la selección del botón
                if currentSelection == titulo {
                    currentSelection = nil
                } else {
                    currentSelection = titulo
                }
            }
        }) {
            VStack(alignment: .leading) {
                // Título del botón
                Text(titulo)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .foregroundColor(.green)
                    .cornerRadius(10)
                
                // Mostrar solo si el botón está expandido
                if currentSelection == titulo {
                    Text(descripcion)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.black)
                        .transition(.opacity)
                }
            }
            .padding()
            .background(Color.white.opacity(0.3)) // Fondo medio transparente
            .cornerRadius(10)
        }
    }
}

#Preview {
    Inicio()
}
