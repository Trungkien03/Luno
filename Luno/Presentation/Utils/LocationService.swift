//
//  LocationService.swift
//  Luno
//
//  Created by Nguyen Trung Kien on 26/3/26.
//

import CoreLocation
import Foundation
import MapKit

public struct MarkerDataModel: Identifiable, Equatable {
    public let id: UUID
    public let coordinate: CLLocationCoordinate2D
    public let title: String?
    public let address: String?
    
    // Nếu bạn làm app Bản đồ Công giáo, có thể thêm các trường này sau:
    // public let parishName: String?
    // public let massTimes: [String]?
    
    public init(id: UUID = UUID(), coordinate: CLLocationCoordinate2D, title: String?, address: String?) {
        self.id = id
        self.coordinate = coordinate
        self.title = title
        self.address = address
    }
    
    public static func == (lhs: MarkerDataModel, rhs: MarkerDataModel) -> Bool {
        return lhs.id == rhs.id
    }
}

public protocol LocationServiceProtocol: AnyObject {
    var delegate: LocationServiceDelegate? { get set }
    func requestLocationPermission()
    func requestCurrentLocation()
    func stopLocationUpdates()
    func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (MarkerDataModel?) -> Void)
}

public protocol LocationServiceDelegate: AnyObject {
    func locationService(_ service: LocationServiceProtocol, didUpdateLocation location: CLLocation)
    func locationService(_ service: LocationServiceProtocol, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    func locationService(_ service: LocationServiceProtocol, didFailWithError error: Error)
}

public final class LocationService: NSObject, LocationServiceProtocol {
    
    public weak var delegate: LocationServiceDelegate?
    
    private let locationManager: CLLocationManager
    
    public override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
    }
    
    public func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func requestCurrentLocation() {
        locationManager.startUpdatingLocation()
        // Hoặc nếu bạn chỉ muốn lấy 1 lần duy nhất để tiết kiệm pin:
        // locationManager.requestLocation()
    }
    
    public func stopLocationUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    public func reverseGeocode(coordinate: CLLocationCoordinate2D, completion: @escaping (MarkerDataModel?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                print("Reverse geocoding error: \(error?.localizedDescription ?? "Unknown")")
                completion(nil)
                return
            }
            
            // Trích xuất tên địa điểm hoặc số nhà/đường
            let title = placemark.name ?? placemark.thoroughfare
            
            // Tạo chuỗi địa chỉ đầy đủ (Tối ưu cho nhiều quốc gia)
            let addressParts = [
                placemark.subThoroughfare, // Số nhà
                placemark.thoroughfare,    // Tên đường
                placemark.subLocality,     // Phường/Xã
                placemark.locality,        // Quận/Huyện
                placemark.administrativeArea // Tỉnh/Thành phố
            ].compactMap { $0 }
            
            let fullAddress = addressParts.joined(separator: ", ")
            
            let marker = MarkerDataModel(
                coordinate: coordinate,
                title: title,
                address: fullAddress
            )
            
            completion(marker)
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        delegate?.locationService(self, didUpdateLocation: location)
    }
    
    // Dành cho iOS 14 trở lên
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        delegate?.locationService(self, didChangeAuthorizationStatus: manager.authorizationStatus)
    }
    
    // Dành cho iOS 13 trở xuống (vẫn nên giữ lại để dự phòng)
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.locationService(self, didChangeAuthorizationStatus: status)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.locationService(self, didFailWithError: error)
    }
}
