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

final class ViewController: UIViewController {

    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var pickerView: UIPickerView!
    
    private let TimeStructures: [TimeStructure] = [Hour(), Minute(), Second()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        setupUnitLabels()
        
    }

    private func setupUnitLabels() {
        TimeStructures.forEach {
            let label = UILabel()
            label.backgroundColor = .systemRed
            label.text = $0.unit
            pickerView.addSubview(label)

            let divideCount = TimeStructures.count + 1
            let pickerDisplayWidth = pickerView.bounds.width - pickerView.layoutMargins.left * 2
            let divideWidth = pickerDisplayWidth / CGFloat(divideCount)
            let halfDivideWidth = divideWidth / 2
            let componentSpace = CGFloat(4) ///（仮）
            let leftWidth = (divideWidth - componentSpace * CGFloat(TimeStructures.count - 1)) / 2
            let eachLeading = leftWidth + halfDivideWidth + CGFloat($0.number - 1) * (divideWidth)
            label.translatesAutoresizingMaskIntoConstraints = false
            [label.leadingAnchor.constraint(equalTo: pickerView.leadingAnchor,
                                            constant: eachLeading),
             label.centerYAnchor.constraint(equalTo: pickerView.centerYAnchor)]
                .forEach { $0.isActive = true }
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
        pickerLabel.textAlignment = .justified
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

