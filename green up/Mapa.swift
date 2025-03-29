import SwiftUI
import MapKit
import CoreLocation

struct PuntoReciclaje: Identifiable {
    let id = UUID() // Proporcionar un identificador único
    let nombre: String
    let coordenadas: CLLocationCoordinate2D
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var location: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error obteniendo la ubicación: \(error.localizedDescription)")
    }
}

struct Mapa: View {
    @StateObject private var locationManager = LocationManager() // Objeto para la ubicación
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 25.6263, longitude: -100.2750),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Zoom inicial
    )

    // Lista de puntos de reciclaje
    let puntosReciclaje = [
        PuntoReciclaje(nombre: "Punto Reciclaje 1", coordenadas: CLLocationCoordinate2D(latitude: 25.6263, longitude: -100.2750)),
        PuntoReciclaje(nombre: "Punto Reciclaje 2", coordenadas: CLLocationCoordinate2D(latitude: 25.6329, longitude: -100.2961)),
        PuntoReciclaje(nombre: "Punto Reciclaje 3", coordenadas: CLLocationCoordinate2D(latitude: 25.6138, longitude: -100.2677)),
        PuntoReciclaje(nombre: "Punto Reciclaje 4", coordenadas: CLLocationCoordinate2D(latitude: 25.6661, longitude: -100.2757)),
        PuntoReciclaje(nombre: "Punto Reciclaje 5", coordenadas: CLLocationCoordinate2D(latitude: 25.6803, longitude: -100.3169)),
        PuntoReciclaje(nombre: "Punto Reciclaje 6", coordenadas: CLLocationCoordinate2D(latitude: 25.6636, longitude: -100.3264))
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Título
                HStack {
                    Text("Mapa")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .padding(.leading, 20)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.top, 20)
                
                // Mapa con puntos de reciclaje
                Map(coordinateRegion: $region, annotationItems: puntosReciclaje) { punto in
                    MapAnnotation(coordinate: punto.coordenadas) {
                        VStack {
                            Image(systemName: "arrow.3.trianglepath")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                                .background(Circle().fill(Color.white).shadow(radius: 5))
                            Text(punto.nombre)
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(height: 400)
                .cornerRadius(15)
                .padding()

                // Botón para hacer zoom out
                Button(action: {
                    withAnimation {
                        region.span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2) // Aumentar zoom out
                    }
                }) {
                    Text("Zoom Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            
            // nav bar
            .overlay(
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
                        
                        Button(action: {
                            //accion para "mapa"
                        }) {
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

struct Mapa_Previews: PreviewProvider {
    static var previews: some View {
        Mapa()
    }
}
