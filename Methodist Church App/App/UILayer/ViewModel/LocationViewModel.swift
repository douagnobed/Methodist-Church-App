//
//  LocationViewModel.swift
//  MethodistMobile
//
//  Created by Q002 on 26/02/2024.
//

import Foundation
import CoreLocation
import Combine
import MapKit

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
       
       @Published var region = MKCoordinateRegion()
    
       
       override init() {
           super.init()
           
           self.locationManager.delegate = self
           self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                   self.setup()
       }

       private func setup() {
         switch locationManager.authorizationStatus {
         //If we are authorized then we request location just once,
         // to center the map
         case .authorizedWhenInUse:
           locationManager.requestLocation()
         //If we don´t, we request authorization
         case .notDetermined:
           locationManager.requestWhenInUseAuthorization()
         default:
           break
         }
       }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print("error:: \(error.localizedDescription)")
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                locationManager.requestLocation()
            }
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

            if locations.first != nil {
                print("location:: \(locations.last)")
            }

        }
    
    
    
//    func distanceInKM(latitude: Int, longitude: Int) -> Double { //Here's the method I made to calculate an actual distance
//
//           let houseCoordinates = CLLocation(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
//
//           let userCoordinates = CLLocation(latitude: lastLocation?.coordinate.latitude ?? 50, longitude: lastLocation?.coordinate.longitude ?? 30)
//           let distance = userCoordinates.distance(from: houseCoordinates) / 1000 //.distance comes in meters so /1000 is to have a KM value
//
//           let s = String(format: "%.0f", distance)
//
//           return Double(s + "Km") ?? 35.5 // This value of 35.5 as placeholder is constantly displayed instead of the actual value
//       }
    
    
    
    func navigateOnGoogleMap(sourceLatitude : Double, sourceLongitude : Double, destinationLatitude : Double, destinationLongitude : Double) {
            let urlGoogleMap : URL = URL(string: "comgooglemaps://?saddr=\(sourceLatitude),\(sourceLongitude)&daddr=\(destinationLatitude),\(destinationLongitude)&directionsmode=driving")!
            
            if UIApplication.shared.canOpenURL(urlGoogleMap) {
                UIApplication.shared.open(urlGoogleMap, options: [:], completionHandler: nil)
                
            } else {
                let urlString = URL(string:"http://maps.google.com/?saddr=\(sourceLatitude),\(sourceLongitude)&daddr=\(destinationLatitude),\(destinationLongitude)&directionsmode=driving")
                
                UIApplication.shared.open(urlString!, options: [:], completionHandler: nil)
            }
        }
    
    
    
}


//
//final class LocationViewModel: NSObject, ObservableObject{
//    @Published var location: CLLocation?
//    @Published var region = MKCoordinateRegion()
//    
//    private let locationManager =  CLLocationManager()
//    
//    override init() {
//        super.init()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.desiredAccuracy = kCLDistanceFilterNone
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation() // Remember to update info.plist
//        locationManager.delegate = self
//    }
//}
//
//extension LocationViewModel: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        self.location = location
//        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
//        
//    }
//}
