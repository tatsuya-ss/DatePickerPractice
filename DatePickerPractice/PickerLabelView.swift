//
//  PickerLabelView.swift
//  DatePickerPractice
//
//  Created by 坂本龍哉 on 2021/09/21.
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

final class PickerLabelView: UIPickerView {
    
    private let TimeStructures: [TimeStructure] = [Hour(), Minute(), Second()]
    private var labels: [UILabel] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reloadAllComponentLabels()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.delegate = self
        self.dataSource = self
    }
    
}

extension PickerLabelView {
    
    private func reloadAllComponentLabels() {
        let fontSize = CGFloat(15)
        let labelTop = self.bounds.origin.y + self.bounds.height / 2 - fontSize
        let labelHeight = self.rowSize(forComponent: 0).height
        var labelOffset = self.bounds.origin.x
        // 変更
        TimeStructures.forEach {
            let row = $0.number - 1
            if self.labels.count == row {
                let label = UILabel()
                label.text = $0.unit
                label.font = UIFont.boldSystemFont(ofSize: fontSize)
                label.sizeToFit()
                
                self.addSubview(label)
                self.labels.append(label)
            }
            let labelWidth = self.labels[row].frame.width
            labelOffset += self.rowSize(forComponent: row).width
            self.labels[row].frame = CGRect(x: labelOffset - labelWidth,
                                          y: labelTop,
                                          width: labelWidth,
                                          height: labelHeight)
        }
    }
    
}

extension PickerLabelView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        TimeStructures.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        TimeStructures[component].timeRange.count
    }
    
}

extension PickerLabelView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        row.description
    }
    
}
