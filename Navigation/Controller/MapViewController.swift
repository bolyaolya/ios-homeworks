//
//  MapViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 09.08.2023.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

final class MapViewController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    //MARK: - Properties
    
    private lazy var locationManager : CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    private lazy var mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var locationButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.circle"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = UIColor(red: 122/255, green: 129/255, blue: 255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(getUserLocation), for: .touchUpInside)
        return button
    }()
    
    private lazy var getRouteButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "map.circle"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = UIColor(red: 122/255, green: 129/255, blue: 255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(getRoute), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteAllPinsButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "mappin.slash.circle"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = UIColor(red: 122/255, green: 129/255, blue: 255, alpha: 1)
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteAllPins), for: .touchUpInside)
        return button
        }()
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getUserLocation()
        pressToAddAnnotation()
    }
    
    //MARK: - Methods
    
    private func setupUI() {
        view.addSubview(mapView)
        view.addSubview(locationButton)
        view.addSubview(getRouteButton)
        view.addSubview(deleteAllPinsButton)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            locationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            locationButton.widthAnchor.constraint(equalToConstant: 30),
            locationButton.heightAnchor.constraint(equalToConstant: 30),
            
            getRouteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            getRouteButton.bottomAnchor.constraint(equalTo: locationButton.topAnchor, constant: -30),
            getRouteButton.widthAnchor.constraint(equalToConstant: 30),
            getRouteButton.heightAnchor.constraint(equalToConstant: 30),
            
            deleteAllPinsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            deleteAllPinsButton.bottomAnchor.constraint(equalTo: getRouteButton.topAnchor, constant: -30),
            deleteAllPinsButton.widthAnchor.constraint(equalToConstant: 30),
            deleteAllPinsButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    //проверяем разрешение на определение локации
    private func checkUserLocationPermissions() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
            
        case .denied, .restricted:
            print("Поменяйте настройки доступа к геолокации")
            
        default:
            fatalError("Непредвиденная ошибка")
        }
    }
    
    //замечаем долгий тап
    private func pressToAddAnnotation() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressAction))
        longPress.delegate = self
        longPress.minimumPressDuration = 1
        mapView.addGestureRecognizer(longPress)
    }
    
    //и реагируем на него, ставя пин на карту
    @objc
    private func longPressAction(gestureRecognizer: UIGestureRecognizer) {
        print("Долгое нажатие на карту")
        let touchPoint = gestureRecognizer.location(in: mapView)
        let coordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        mapView.addAnnotation(annotation)
        print("Установлен пин с координатами: \(annotation.coordinate)")
        getRouteButton.isEnabled = true
        deleteAllPinsButton.isEnabled = true
    }
    
    //обновляем локацию разово
    @objc
    private func getUserLocation() {
        locationManager.requestLocation()
    }
    
    //строим маршрут от местоположения до пина
    @objc
    private func getRoute() {
        guard let userLocation = locationManager.location?.coordinate,
              let pinLocation = mapView.annotations.first?.coordinate else {
                print("Невозможно построить маршрут. Местоположение пользователя или пин не определены.")
                return
        }
        
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let pinPlacemark = MKPlacemark(coordinate: pinLocation)
        
        let userMapItem = MKMapItem(placemark: userPlacemark)
        let pinMapItem = MKMapItem(placemark: pinPlacemark)
        
        let request = MKDirections.Request()
        request.source = userMapItem
        request.destination = pinMapItem
        request.transportType = .automobile
        
        print("User Location: \(userLocation)")
        print("Pin Location: \(pinLocation)")
        
        let directions = MKDirections(request: request)
        directions.calculate { [unowned self] response, error in
            if let error = error {
                print("Ошибка при построении маршрута: \(error.localizedDescription)")
                return
            }
            if let route = response?.routes.first {
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
            }
        }
    }
    
    //удаляем все пины и маршруты
    @objc
    private func deleteAllPins() {
        print("Нажата кнопка удаления всех пинов")
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationPermissions()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Местоположение: \(location)")
            mapView.setCenter(location.coordinate, animated: true)
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
            mapView.setRegion(region,animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка определения местоположения: \(error.localizedDescription)")
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polylineOverlay = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polylineOverlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}


