import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var locationReady = false
    var statusText = "Requesting location..."
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            self.locationReady = true
            self.statusText = "GPS Ready ✅"
            self.objectWillChange.send()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.statusText = "Location unavailable"
            self.objectWillChange.send()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            switch status {
            case .authorizedWhenInUse, .authorizedAlways:
                self.statusText = "GPS Ready ✅"
                self.manager.startUpdatingLocation()
            case .denied:
                self.statusText = "Location denied ❌"
            default:
                self.statusText = "Requesting..."
            }
            self.objectWillChange.send()
        }
    }
    
    var googleMapsLink: String {
        return "https://maps.google.com/?q=\(latitude),\(longitude)"
    }
    
    var whatsappMessage: String {
        return "🚨 EMERGENCY! Ragini needs help! Please call or come immediately!\n📍 My location: \(googleMapsLink)"
    }
}
