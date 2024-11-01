import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    let myLocationButton = UIButton(type: .system)
    var currentRoute: MKRoute? // Переменная для хранения текущего маршрута

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        setupLocationManager()
        setupLongPressGesture()
        setupUI()
    }

    // MARK: - Настройка карты
    func setupMapView() {
        mapView.frame = view.bounds
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
    }

    // MARK: - Настройка геолокации
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // MARK: - Обработка долгого нажатия для добавления пинов
    func setupLongPressGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let location = gesture.location(in: mapView)
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Метка"
            mapView.addAnnotation(annotation)
        }
    }

    // MARK: - Построение маршрута
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let destinationCoordinate = view.annotation?.coordinate else { return }
        guard let sourceCoordinate = locationManager.location?.coordinate else { return }

        // Удаление предыдущего маршрута перед добавлением нового
        if let currentRoute = currentRoute {
            mapView.removeOverlay(currentRoute.polyline)
        }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            self.currentRoute = route // Сохраняем текущий маршрут
            self.mapView.addOverlay(route.polyline)
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.lineWidth = 4.0
            renderer.strokeColor = .blue
            return renderer
        }
        return MKOverlayRenderer()
    }

    // MARK: - Переключение вида карты
    @objc func mapTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }

    // MARK: - Удаление всех добавленных точек
    @objc func removeAllPins() {
        let annotations = mapView.annotations.filter { !($0 is MKUserLocation) }
        mapView.removeAnnotations(annotations)
    }

    // MARK: - Центрирование на текущем местоположении
    @objc func centerToUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }

    // MARK: - Настройка UI
    func setupUI() {
        // Сегментированный контрол для выбора типа карты
        let mapTypeSegmentedControl = UISegmentedControl(items: ["Стандарт", "Спутник", "Гибрид"])
        mapTypeSegmentedControl.selectedSegmentIndex = 0
        mapTypeSegmentedControl.addTarget(self, action: #selector(mapTypeChanged(_:)), for: .valueChanged)
        mapTypeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapTypeSegmentedControl)

        NSLayoutConstraint.activate([
            mapTypeSegmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mapTypeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapTypeSegmentedControl.widthAnchor.constraint(equalToConstant: 300),
            mapTypeSegmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Кнопка для центрирования на текущем местоположении
        myLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        myLocationButton.tintColor = .black // Устанавливаем черный цвет
        myLocationButton.addTarget(self, action: #selector(centerToUserLocation), for: .touchUpInside)
        myLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myLocationButton)

        NSLayoutConstraint.activate([
            myLocationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            myLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            myLocationButton.widthAnchor.constraint(equalToConstant: 40),
            myLocationButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Кнопка для удаления всех меток
        let removePinsButton = UIButton(type: .system)
        removePinsButton.setImage(UIImage(systemName: "trash"), for: .normal)
        removePinsButton.tintColor = .black // Устанавливаем черный цвет
        removePinsButton.addTarget(self, action: #selector(removeAllPins), for: .touchUpInside)
        removePinsButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(removePinsButton)

        NSLayoutConstraint.activate([
            removePinsButton.topAnchor.constraint(equalTo: myLocationButton.bottomAnchor, constant: 20),
            removePinsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            removePinsButton.widthAnchor.constraint(equalToConstant: 40),
            removePinsButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
