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
    var number: Int { get }
}

struct Hour: TimeStructure {
    var timeRange: [Int] = [Int](0...23)
    var unit: String = "時間"
    var number: Int = 1
}

struct Minute: TimeStructure {
    var timeRange: [Int] = [Int](0...59)
    var unit: String = "分"
    var number: Int = 2
}

struct Second: TimeStructure {
    var timeRange: [Int] = [Int](0...59)
    var unit: String = "秒"
    var number: Int = 3
}

struct Millisecond: TimeStructure {
    var timeRange: [Int] = [Int](0...59)
    var unit: String = "秒"
    var number: Int = 4
}


final class ViewController: UIViewController {

    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    private let TimeStructures: [TimeStructure] = [Hour(), Minute(), Second(), Millisecond()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        setupUnitLabels()
        
    }

    private func setupUnitLabels() {
        let divideCount = TimeStructures.count + 1
        let width = (pickerView.bounds.width) / CGFloat(divideCount)
        let layoutMargins = pickerView.layoutMargins.left
        TimeStructures.forEach {
            let label = UILabel()
            label.backgroundColor = .systemRed
            label.text = $0.unit
            pickerView.addSubview(label)

            label.translatesAutoresizingMaskIntoConstraints = false
            [label.leadingAnchor.constraint(equalTo: pickerView.leadingAnchor,
                                           constant: width * CGFloat($0.number) - layoutMargins),
             label.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor)]
                .forEach { $0.isActive = true }
            
//            label.frame = CGRect(x: width * CGFloat($0.number) - label.bounds.width / 2,
//                                 y: pickerView.bounds.height / 2 - label.bounds.height / 2,
//                                 width: label.bounds.width,
//                                 height: label.bounds.height)
            
        }
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
                    widthForComponent component: Int) -> CGFloat {
        pickerView.bounds.width / CGFloat(TimeStructures.count + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textAlignment = .left
        pickerLabel.text = String(TimeStructures[component].timeRange[row])
        pickerLabel.backgroundColor = .systemYellow
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

