//
//  TheaterInfo.swift
//  AutoLayoutProject
//
//  Created by 김하은 on 2023/08/24.
//

import Foundation
import CoreLocation

enum TheaterType: String{
    case megabox = "메가박스"
    case lotteCinema = "롯데시네마"
    case cgv = "CGV"
    case all
}

struct Theater {
    let type: TheaterType.RawValue
    let location: String
    let coordinate: CLLocationCoordinate2D
}

struct TheaterList {
    static var mapAnnotations: [Theater] = [
        Theater(type: TheaterType.lotteCinema.rawValue, location: "롯데시네마 서울대입구", coordinate: CLLocationCoordinate2D(latitude: 37.4824761978647, longitude: 126.9521680487202)),
        Theater(type: TheaterType.lotteCinema.rawValue, location: "롯데시네마 가산디지털", coordinate: CLLocationCoordinate2D(latitude: 37.47947929602294, longitude: 126.88891083192269)),
        Theater(type: TheaterType.megabox.rawValue, location: "메가박스 이수", coordinate: CLLocationCoordinate2D(latitude: 37.48581351541419, longitude: 126.98092132899579)),
        Theater(type: TheaterType.megabox.rawValue, location: "메가박스 강남", coordinate: CLLocationCoordinate2D(latitude: 37.49948523972615, longitude: 127.02570417165666)),
        Theater(type: TheaterType.cgv.rawValue, location: "CGV 영등포", coordinate: CLLocationCoordinate2D(latitude: 37.52666023337906, longitude: 126.9258351013706)),
        Theater(type: TheaterType.cgv.rawValue, location: "CGV 용산 아이파크몰", coordinate: CLLocationCoordinate2D(latitude: 37.53149302830903, longitude: 126.9654030486416))
    ]
}
