//
//  Perfil.swift
//  green up
//
//  Created by Alumno on 28/03/25.
//

import SwiftUI

struct Perfil: View {
    @State private var usuarioNombre: String = "Yaheli"
    // estas variables son para el seguimiento del progreso del reciclaje
    @State private var reciclado: Int = 0
    @State private var maxReciclado: Int = 10 // limite de objetos reciclados
    @State private var objetosReciclados: [String] = [] // lista d eobjetos reciclados
    @State private var nuevoObjeto: String = "" // nombre del objeto que se agrega
    @State private var editandoIndice: Int? = nil // indice del objeto que se esta editando
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Perfil")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding(.leading, 20)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 20)
                
                // saludo al usuario
                Text("¡Hola, \(usuarioNombre)!") // se usa la variable de "usuarioNombre"
                    .font(.title2)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                // termometro de reciclaje
                VStack(alignment: .leading) {
                    // seccion de progreso de reciclaje
                    Text("Progreso de Reciclaje Diario")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    
                    // bara de progreso (termometro)
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 300, height: 30)
                            .foregroundColor(Color.gray.opacity(0.3))
                        
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: CGFloat(reciclado) / CGFloat(maxReciclado) * 300, height: 30)
                            .overlay( // Se usa overlay en lugar de fill
                                LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading, endPoint: .trailing)
                                )
                            .clipShape(RoundedRectangle(cornerRadius: 20)) // sirve para que se respete el degradado conforme al borde
                            .animation(.easeInOut, value: reciclado)
                    }
                    Text("\(reciclado)/\(maxReciclado) objetos reciclados")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
                .padding()
                
                // lista de objetos reciclados con edicion
                
                VStack(alignment: .leading) {
                    Text("Lista de Reciclaje Diario")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    
                    List {
                        ForEach(objetosReciclados.indices, id: \.self) { index in
                            HStack {
                                if editandoIndice == index {
                                    // campo de texto para editar el nombre
                                    TextField("Nuevo Nombre", text: Binding(get: { objetosReciclados[index]}, set: {objetosReciclados[index] = $0}
                                    ))
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                } else {
                                    Text("♻️\(objetosReciclados[index])")
                                }
                                
                                Spacer()
                                
                                // boton para editar
                                Button(action: {
                                    editandoIndice = (editandoIndice == index) ? nil : index
                                }) {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    
                    .frame(height: 150)
                }
                .padding()
                
                // campo de texto para nuevos obejetos
                VStack {
                    HStack {
                        TextField("Nombre del objeto", text: $nuevoObjeto)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            if reciclado < maxReciclado, !nuevoObjeto.isEmpty {
                                objetosReciclados.append(nuevoObjeto)
                                reciclado += 1
                                nuevoObjeto = " "
                            }
                        }) {
                            
                            Text("Agregar")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            
            .padding()
            
            .background(
                // fondo de la pantalla
                LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            // nav bar
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            //accion para "inicio"
                        }) {
                            NavigationLink(destination: Inicio()) {
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
                        }
                        Spacer()
                        
                        NavigationLink(destination: Mapa()) {
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
                        
                        NavigationLink(destination: _R()) {
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
                        
                        Button(action: {
                            // accion para ir a "perfil, ya se esta en esa pantalla pero la consistencia
                        }){
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

#Preview {
    Perfil()
}
