import SwiftUI

// Estructura que define la información de cada producto
struct Product {
    let name: String
    let recycleInfo: String
    let reuseInfo: String
    let reduceInfo: String
}

struct _R: View {
    @State private var searchText = ""
    
    // Base de datos ampliada de productos
    let products: [Product] = [
        Product(name: "Botella de plástico",
                recycleInfo: "Lavar, separar tapa y depositar en contenedor de plásticos.",
                reuseInfo: "Utilizarla como maceta o para hacer manualidades.",
                reduceInfo: "Opta por botellas reutilizables."),
        Product(name: "Caja de cartón",
                recycleInfo: "Aplastar y depositar en contenedor de cartón.",
                reuseInfo: "Usarla para guardar objetos o hacer decoraciones.",
                reduceInfo: "Preferir empaques reusables o reciclados."),
        Product(name: "Latas de aluminio",
                recycleInfo: "Lavar y depositar en contenedor de metales.",
                reuseInfo: "Ideal para proyectos de arte o almacenamiento pequeño.",
                reduceInfo: "Evitar productos con excesivo empaque en aluminio."),
        Product(name: "Papel y revistas",
                recycleInfo: "Separar papel limpio y depositarlo en contenedor de papel.",
                reuseInfo: "Reciclarlo para manualidades o papel reciclado.",
                reduceInfo: "Reducir el uso imprimiendo solo lo necesario."),
        Product(name: "Envases de vidrio",
                recycleInfo: "Lavar y depositar en contenedor de vidrio.",
                reuseInfo: "Utilizarlos como frascos para conservas o decoraciones.",
                reduceInfo: "Optar por productos con envases reutilizables."),
        Product(name: "Electrodomésticos pequeños",
                recycleInfo: "Llevar a puntos de recolección autorizados para electrónicos.",
                reuseInfo: "Reparar y donar o vender en buen estado.",
                reduceInfo: "Comprar productos con mayor durabilidad y eficiencia energética."),
        Product(name: "Ropa usada",
                recycleInfo: "Donar a organizaciones que reciclan textiles.",
                reuseInfo: "Intercambiar o reinventar prendas con modificaciones creativas.",
                reduceInfo: "Comprar ropa de buena calidad para mayor durabilidad."),
        Product(name: "Madera",
                recycleInfo: "Consultar centros de reciclaje de madera o centros de construcción.",
                reuseInfo: "Utilizar para proyectos de bricolaje o muebles caseros.",
                reduceInfo: "Evitar desperdicio reutilizando restos en lugar de desecharlos.")
    ]
    
    // Filtra los productos según el texto de búsqueda (sin distinguir mayúsculas/minúsculas)
    var filteredProducts: [Product] {
        if searchText.isEmpty { return [] }
        return products.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Encabezado "3R"
                HStack {
                    Text("3R")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding(.leading, 20)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 20)
                
                // Campo de búsqueda
                TextField("Buscar producto", text: $searchText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 10)
                
                // Lista de resultados filtrados
                if filteredProducts.isEmpty {
                    if searchText.isEmpty {
                        Spacer()
                    } else {
                        Text("No se encontraron resultados")
                            .padding()
                        Spacer()
                    }
                } else {
                    List(filteredProducts, id: \.name) { product in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(product.name)
                                .font(.headline)
                            Text("Reciclar: \(product.recycleInfo)")
                                .font(.subheadline)
                            Text("Reutilizar: \(product.reuseInfo)")
                                .font(.subheadline)
                            Text("Reducir: \(product.reduceInfo)")
                                .font(.subheadline)
                        }
                        .padding() // Padding interno para el contenido
                        .background(
                            // Vista de fondo con esquinas redondeadas
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.8))
                                .shadow(radius: 3)
                        )
                        .padding(.vertical, 4) // Separación entre celdas
                    }
                    .listStyle(PlainListStyle())
                }
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, .white]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .overlay(
                // Barra de navegación inferior
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
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
                        
                        Button(action: {
                            // Acción para "3R"
                        }) {
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

struct _R_Previews: PreviewProvider {
    static var previews: some View {
        _R()
    }
}
