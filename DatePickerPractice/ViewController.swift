//
//  ViewController.swift
//  DatePickerPractice
//
//  Created by 坂本龍哉 on 2021/09/20.
//

import UIKit

protocol TimeStructure {
    var timeRange: [Int] { get }
    var unit: String { get }
}

struct Hour: TimeStructure {
    var timeRange: [Int] = [Int](0...23)
    var unit: String = "時間"
}

struct Minute: TimeStructure {
    var timeRange: [Int] = [Int](0...59)
    var unit: String = "分"
}

struct Second: TimeStructure {
    var timeRange: [Int] = [Int](0...59)
    var unit: String = "秒"
}

final class ViewController: UIViewController {

    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    private let TimeStructures: [TimeStructure] = [Hour(), Minute(), Second()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        
    }

}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        TimeStructures.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        TimeStructures[component].timeRange.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = .center
        pickerLabel.text = String(TimeStructures[component].timeRange[row])
        return pickerLabel
    }
    
}

extension ViewController: UIPickerViewDelegate {
    
}

extension ViewController {
    
    private func setupPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
}

