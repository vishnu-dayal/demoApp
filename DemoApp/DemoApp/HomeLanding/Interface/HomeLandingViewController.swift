//
//  HomeLandingViewController.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 12/02/21.
//

import Foundation
import UIKit
import SwiftUI

class HomeLandingViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var btnSource: UIButton!
    @IBOutlet weak var btnDestination: UIButton!
    @IBOutlet weak var btnDepartureDate: UIButton!
    @IBOutlet weak var btnGetFlights: UIButton!
    
    var countryJson: CountryResponse?
    var isSourceSelected: Bool = false
    
    var originCode: String?
    var destinationCode: String?
    var departureDate: String?
    
    @IBSegueAction func showDetails(_ coder: NSCoder) -> UIViewController? {
        let listView = FlightListView()
        return UIHostingController(coder: coder, rootView: listView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        callListOfCountriesAPI()
    }

    func setUpView() {
        self.title = "Home"
        pickerView.isHidden = true
        datePicker.isHidden = true
        datePicker.datePickerMode = .date
        setDate(date: datePicker.date)
    }
    
    func callListOfCountriesAPI() {
        let locale = Locale.current
        let request = APIRequest(apiKey: Constants().apiKey, endPoint: locale.identifier.replacingOccurrences(of: "_", with: "-"))
        APIManager.sharedInstance.getListOfCountries(request: request, completionHandler: { (jsonData) in
            if let data = jsonData {
                self.parseCountryResponse(json: data)
            }
        })
    }
    
    private func parseCountryResponse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonResponse = try? decoder.decode(CountryResponse.self, from: json) {
            self.countryJson = jsonResponse
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
        }
    }
    
    private func setDate(date: Date) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.locale = Locale.current
        dateFormatterGet.dateFormat = "YYYY-MM-dd"
        departureDate = dateFormatterGet.string(from: date)
        if let date = departureDate {
            btnDepartureDate.setTitle("Departure: \(date)", for: .normal)
        }

    }
    
    @IBAction func tapBtnSource(sender: UIButton) {
        isSourceSelected = true
        pickerView.isHidden = false
        datePicker.isHidden = true
    }

    @IBAction func tapBtnDestination(sender: UIButton) {
        isSourceSelected = false
        pickerView.isHidden = false
        datePicker.isHidden = true
    }

    @IBAction func tapBtnDepartureDate(sender: UIButton) {
        pickerView.isHidden = true
        datePicker.isHidden = false
    }
    
    @IBAction func tapBtnGetFlights(sender: UIButton) {
        pickerView.isHidden = true
        datePicker.isHidden = true
        if let origin = originCode, !origin.isEmpty, let destination = destinationCode, !destination.isEmpty, let departure = departureDate, !departure.isEmpty{
            var swiftUIView = FlightListView()
            swiftUIView.setData(originCode: origin, destinationCode: destination, departure: departure)
            let viewCtrl = UIHostingController(rootView: swiftUIView)
            self.navigationController?.pushViewController(viewCtrl, animated: true)
        }
    }

    @IBAction func valueChangedDatePicker(sender: UIDatePicker) {
        setDate(date: sender.date)
    }
}

extension HomeLandingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryJson?.countries?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryJson?.countries?[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isSourceSelected {
            btnSource.setTitle(countryJson?.countries?[row].name, for: .normal)
            originCode = countryJson?.countries?[row].code
            pickerView.isHidden = true
        } else {
            btnDestination.setTitle(countryJson?.countries?[row].name, for: .normal)
            destinationCode = countryJson?.countries?[row].code
            pickerView.isHidden = true
        }
    }
}

class MyHostViewController: UIHostingController<FlightListView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: FlightListView());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

