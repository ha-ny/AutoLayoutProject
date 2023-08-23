//
//  FindCinemaViewController.swift
//  AutoLayoutProject
//
//  Created by 김하은 on 2023/08/23.
//

import UIKit
import MapKit
import CoreLocation //1. 위치 임포트
import SnapKit

class FindCinemaViewController: UIViewController {

    let mapView = MKMapView()
    //2. 위치 매니저 생성 - 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    let locationButton = {
        let view = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        let image = UIImage(systemName: "location.circle", withConfiguration: configuration)
        view.setImage(image, for: .normal)
        view.tintColor = .orange
        return view
    }()
    
    let filterButton = {
        let view = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 28)
        let image = UIImage(systemName: "line.3.horizontal.circle.fill", withConfiguration: configuration)
        view.setImage(image, for: .normal)
        view.tintColor = .green
        return view
    }()
    
    var islocationButtonClick = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        view.addSubview(locationButton)
        view.addSubview(filterButton)
        locationButton.addTarget(self, action: #selector(locationButtonClick), for: .touchUpInside)
        filterButton.addTarget(self, action: #selector(filterButtonClick), for: .touchUpInside)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        locationButton.snp.makeConstraints { make in
            make.left.bottom.equalTo(view.safeAreaLayoutGuide).inset(22)
            make.size.equalTo(view.snp.width).multipliedBy(0.15)
        }
        
        filterButton.snp.makeConstraints { make in
            make.right.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.size.equalTo(view.snp.width).multipliedBy(0.1)
        }
        
        //3. 프로토콜 연결
        locationManager.delegate = self
        
        //4. 위치 서비스가 켜져있나 확인
        checkDeviceLocationAuthorization()
    }
    
    @objc func locationButtonClick() {
        
        islocationButtonClick =  true
        checkDeviceLocationAuthorization()
    }

    func checkDeviceLocationAuthorization() {
        
        //위치 서비스가 켜져있나 확인 (main에서 돌리면 오류난다!)
        DispatchQueue.global().async {
            
            //위치 서비스 활성화를 체크함
            if CLLocationManager.locationServicesEnabled(){
            
                let authorization: CLAuthorizationStatus
                
                //현재 사용자의 위치 권한 상태를 가지고 옴
                authorization = self.locationManager.authorizationStatus
                
                //5. 위치 권한 상태 구분
                self.checkCurrentLocationAuthorization(statue: authorization)
            }
        }
    }
    
    func checkCurrentLocationAuthorization(statue: CLAuthorizationStatus) {
        
        //위치 권한 상태 구분
        //CLAuthorizationStatus 타입인 statue을 넣으면 자동으로 switch setting
        switch statue {
        case .notDetermined: //아무것도 선택하지 않음(초기 상태)
            
            //desiredAccuracy: 정확도, requestWhenInUseAuthorization: 권한 요청 팝업 띄우기!
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("restricted")
        case .denied: // 위치 권한 거부
            
            print(islocationButtonClick, "--------")
            //위치설정 버튼 클릭시 권한 거부 -> Alert
            if islocationButtonClick{
                islocationButtonClick = false
                
                DispatchQueue.main.async {
                    let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
                    let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
                        if let setting = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(setting)
                        }
                    }
                    let cancel = UIAlertAction(title: "취소", style: .default)
                    requestLocationServiceAlert.addAction(cancel)
                    requestLocationServiceAlert.addAction(goSetting)
                    
                    self.present(requestLocationServiceAlert, animated: true, completion: nil)
                }
            }else{
                // 위치 권한 거부시 -> 캠퍼스 (기본)
                let locationCode = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
                self.setMyLocation(location: locationCode)
            }
            
        case .authorizedAlways: //항상 허용
            //사용자의 위치를 가져옴 -> didUpdateLocations 매서드 실행
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse: // 한번 허용 (위치 권한이 생김)
            //사용자의 위치를 가져옴 -> didUpdateLocations 매서드 실행
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            print("error")
        }
    }
    
    func setMyLocation(location: CLLocationCoordinate2D){
        
        //지도 중심에 center가 뜸
        let center = location
        
        // 중심 기준으로 지도 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 150, longitudinalMeters: 150)
        mapView.setRegion(region, animated: true)
        
        //지도에 어노테이션(핀) 추가
        addAnnotations(theater: TheaterType.all)
    }
    
    func addAnnotations(theater: TheaterType){
        
        mapView.removeAnnotations(mapView.annotations)
        
        var theaterList = TheaterList.mapAnnotations
        
        if theater != TheaterType.all{
            theaterList = TheaterList.mapAnnotations.filter{ $0.type == theater.rawValue }
            print(theaterList)
        }
        
        for data in theaterList{
            let annotation = MKPointAnnotation()
            annotation.title = data.location
            annotation.coordinate = data.coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc func filterButtonClick(){
        let theaterActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megabox = UIAlertAction(title: TheaterType.megabox.rawValue, style: .default){_ in
            self.addAnnotations(theater: TheaterType.megabox)
        }
        
        let lotteCinema = UIAlertAction(title: TheaterType.lotteCinema.rawValue, style: .default){_ in
            self.addAnnotations(theater: TheaterType.lotteCinema)
        }
        
        let cgv = UIAlertAction(title: TheaterType.cgv.rawValue, style: .default){_ in
            self.addAnnotations(theater: TheaterType.cgv)
        }
        
        let all = UIAlertAction(title: "전체보기", style: .default){_ in
            self.addAnnotations(theater: TheaterType.all)
        }
        
        let cancle = UIAlertAction(title: "취소", style: .cancel)
        theaterActionSheet.addAction(megabox)
        theaterActionSheet.addAction(lotteCinema)
        theaterActionSheet.addAction(cgv)
        theaterActionSheet.addAction(all)
        theaterActionSheet.addAction(cancle)
        
        self.present(theaterActionSheet, animated: true, completion: nil)
    }
}

extension FindCinemaViewController: CLLocationManagerDelegate{
    
    //사용자의 위치를 성공적으로 가져온 경우 실행 / startUpdatingLocation() 사용시 탐
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 위치를 성공적으로 가져온 경우 -> 사용자의 위치를 중앙으로
        let locationCode = locations[0].coordinate
        self.setMyLocation(location: locationCode)
        
        //위치를 수시로 가져오지 않기 위해 가져오고나면 멈춤
        locationManager.stopUpdatingLocation()
    }
    
    //사용자의 권한 상태가 바뀔 때 알려줌 초기 상태(notDetermined) 세팅 후 한번허용으로 변경시 -> 2번 탐
    // 거부했다가 설정에서 변경, 위치를 가져오는 도중에 거부되는 것 등을 감지
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //위치 서비스의 상태를 체크 후 checkCurrentLocationAuthorization에서 위치 권한 체크 -> 허용으로 되어 있으면 사용자의 위치를 가져오는 것까지
        checkDeviceLocationAuthorization()
    }
    
}
