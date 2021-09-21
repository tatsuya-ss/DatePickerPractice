//
//  ViewController.swift
//  DatePickerPractice
//
//  Created by 坂本龍哉 on 2021/09/20.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var pickerView: UIPickerView!
    
    private let TimeStructures: [TimeStructure] = [Hour(), Minute(), Second()]
    private var labels: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        reloadAllComponentLabels()
    }
    
}

extension ViewController {
    
    private func setup() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    private func reloadAllComponentLabels() {
        let fontSize = CGFloat(15)
        let labelTop = pickerView.bounds.origin.y + pickerView.bounds.height / 2 - fontSize
        let labelHeight = pickerView.rowSize(forComponent: 0).height
        var labelOffset = pickerView.bounds.origin.x
        // 変更
        TimeStructures.forEach {
            let row = $0.number - 1
            if self.labels.count == row {
                let label = UILabel()
                label.text = $0.unit
                label.font = UIFont.boldSystemFont(ofSize: fontSize)
                label.sizeToFit()
                pickerView.addSubview(label)
                self.labels.append(label)
            }
            let labelWidth = self.labels[row].frame.width
            labelOffset += pickerView.rowSize(forComponent: row).width
            self.labels[row].frame = CGRect(x: labelOffset - labelWidth,
                                          y: labelTop,
                                          width: labelWidth,
                                          height: labelHeight)
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
    
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        row.description
    }

}
