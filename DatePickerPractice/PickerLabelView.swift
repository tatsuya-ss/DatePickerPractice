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
