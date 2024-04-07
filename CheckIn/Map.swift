import SwiftUI
import MapKit

@available(iOS 16.4, *)
struct SheetView: View {
    var empireStateBuildingHandler: ((CLLocationCoordinate2D) -> Void)? // Callback closure
    var body: some View {

        Text("Choose a location")
            .font(.largeTitle)
            .bold()
            .presentationDetents([ .medium, .large])
            .presentationBackground(.thinMaterial)
        Menu("Options") {
            Button("Waffle-House") {
                empireStateBuildingHandler?(CLLocationCoordinate2D(latitude: 37.942, longitude: -91.791)) // Call the closure with new coordinates
            }
            Button("Walmart") {
                empireStateBuildingHandler?(CLLocationCoordinate2D(latitude: 37.938, longitude: -91.779)) // Call the closure with new coordinates
            }
            Button("Movie Theater") {
                empireStateBuildingHandler?(CLLocationCoordinate2D(latitude: 37.960, longitude: -91.755)) // Call the closure with new coordinates
            }
        }
    }
}

@available(iOS 17.0, *)
struct RouteView: View {
    @State private var route: MKRoute?
    @State private var travelTime: String?
    @State private var isSheetPresented = false // State variable to control the sheet presentation
    
    @State private var empireStateBuilding = CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.9857) // Initial value
    
    
    //Locations Predefined
    let columbiaUniversity = CLLocationCoordinate2D(latitude: 37.956, longitude: -91.776)

    
    var body: some View {
        
        Map {
            if let route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 8)
            }
        }
        .overlay(alignment: .bottom, content: {
            HStack {
                if let travelTime {
                    Text("Travel time: \(travelTime)")
                        .padding()
                        .font(.headline)
                        .foregroundStyle(.black)
                        .background(.ultraThinMaterial)
                        .cornerRadius(15)
                }
            }
        })
        .onAppear(perform: {
            fetchRouteFrom(empireStateBuilding, to: columbiaUniversity)
        })
        
        Button("Present Sheet"){
            isSheetPresented.toggle()
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetView(empireStateBuildingHandler: { newCoordinate in empireStateBuilding = newCoordinate
                // Fetch route with the new starting point
                fetchRouteFrom(empireStateBuilding, to: columbiaUniversity)
            })
        }

        
    }
}

@available(iOS 17.0, *)
extension RouteView {
    
    private func fetchRouteFrom(_ source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        
        Task {
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            getTravelTime()
        }
    }
    
    private func getTravelTime() {
        guard let route else { return }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        travelTime = formatter.string(from: route.expectedTravelTime)
    }
}


#Preview {
    if #available(iOS 17.0, *) {
        RouteView()
    } else {
        Text("Preview not available for iOS versions earlier than iOS 17.0")
                    .foregroundColor(.red)
                    .padding()
    }
}
