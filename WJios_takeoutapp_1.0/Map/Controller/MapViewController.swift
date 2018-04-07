//
//  MapViewController.swift
//  WJios_takeoutapp_1.0
//
//  Created by WangJie on 28/03/2018.
//  Copyright © 2018 WangJie. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewDelegate: class {
    func ClickTheCommit(mapView : MapViewController, address : String)
}
class MapViewController: UIViewController {
    
    private let AddAddressStoryBoardID = "AddAddressStoryBoardID"

    @IBOutlet weak var commitBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var labelBtn: UIButton!
    var selectedAnnotion : MKAnnotation!
    //储存离地位置
    var address: String = ""
    //地图服务
    let locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    var lock = NSLock()
    var delegate : MapViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    @IBAction func commit(_ sender: Any) {
        //通知代理
        self.delegate?.ClickTheCommit(mapView: self, address: address)
        //返回前页
        self.navigationController?.popViewController(animated: true)
    }
}

extension MapViewController{
    private func setupUI(){
        //设置地图
        let mapView = MKMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        
        let coordinate2D = CLLocationCoordinate2D(latitude: 32.113147, longitude: 118.956368)
        let region = MKCoordinateRegionMake(coordinate2D, MKCoordinateSpanMake(0.02, 0.02))
        mapView.setRegion(region, animated: true)
        
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate2D
//        annotation.title = "当前位置"
//        annotation.subtitle = "南京大学？"
//        mapView.addAnnotation(annotation)
        
        self.view.addSubview(mapView)
        self.view.bringSubview(toFront: commitBtn)
        self.view.bringSubview(toFront: labelBtn)
        self.view.bringSubview(toFront: image)
        self.view.bringSubview(toFront: btn)
        //设置location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //定位精确度（最高）一般有电源接入，比较耗电
        //kCLLocationAccuracyNearestTenMeters;                    //精确到10米
        locationManager.distanceFilter = 50                       //设备移动后获得定位的最小距离（适合用来采集运动的定位）
        locationManager.requestWhenInUseAuthorization()           //弹出用户授权对话框，使用程序期间授权（ios8后)
        //requestAlwaysAuthorization;                             //始终授权
        locationManager.startUpdatingLocation()
        
    }
}

extension MapViewController : MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerCoordinate : CLLocationCoordinate2D = mapView.region.center
        let location = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error: " + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
            }
            else {
                print("Error existed in the data received from geocoder")
            }
            
        })
        
    }
}

extension MapViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lock.lock()
        currentLocation = locations.last                        //注意：获取集合中最后一个位置（最新的位置）
        print("定位经纬度为：\(currentLocation.coordinate.latitude)")
        print(currentLocation.coordinate.longitude)
        //进行反地理编译
        // 将经纬度转化成地址
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil {
                print("Reverse geocoder failed with error: " + error!.localizedDescription)
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                self.displayLocationInfo(pm)
            }
            else {
                print("Error existed in the data received from geocoder")
            }
            
        })
        
        //locationManager.stopUpdatingLocation()
        lock.unlock()
        
    }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        guard let containsPlacemark = placemark else {return}
        
        let subLocality = (containsPlacemark.subLocality != nil) ? containsPlacemark.subLocality : ""
        let thoroughfare = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""
        let subthoroughfare = (containsPlacemark.subThoroughfare != nil) ? containsPlacemark.subThoroughfare : ""
        let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
        let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
        let adminstrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
        let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
        
        if thoroughfare != "" {
            address = "\(thoroughfare!)"
        }
        else{
            address = "\(locality ?? "")\(subLocality ?? "")"
        }
        labelBtn.setTitle(address, for: .normal)
        
        
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: Error) {
        print("定位出错拉！！\(error)")
    }
}
