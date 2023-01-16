//
//  FastingViewModel.swift
//  FastingTimer
//
//  Created by Амир Кайдаров on 1/16/23.
//

import Foundation

enum FastingState{
    case notStarted
    case fasting
    case feeding
}

enum FastingPlan : String {
    case beginner = "12:12"
    case intermediate = "16:8"
    case advanced = "20:4"
    
    var fastingPeriod : Double {
        switch self {
        case .beginner:
            return 12
        case .intermediate:
            return 16
        case .advanced:
            return 20
        }
    }
}

class FastingViewModel: ObservableObject {
    @Published private(set) var state : FastingState = .notStarted
    @Published private(set) var plan : FastingPlan = .intermediate
    
    func toggleState() {
        state = state == .fasting ? .feeding : .fasting
    }
}
