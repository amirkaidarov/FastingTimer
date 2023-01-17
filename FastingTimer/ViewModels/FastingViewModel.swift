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
    @Published private(set) var startTime : Date {
        didSet {
            if state == .fasting {
                self.endTime = startTime.addingTimeInterval(fastingTime)
            } else {
                self.endTime = startTime.addingTimeInterval(feedingTime)
            }
        }
    }
    @Published private(set) var endTime : Date
    
    @Published private(set) var isElapsed : Bool = false
    
    @Published private(set) var elapsedTime : Double = 0.0
    @Published private(set) var progress : Double = 0.0
    
    var fastingTime : Double {
        return plan.fastingPeriod * 60 * 60
    }
    
    var feedingTime : Double {
        return (24 - plan.fastingPeriod) * 60 * 60
    }
    
    init() {
        let calendar = Calendar.current
        let components = DateComponents(hour: 20)
        
        let scheduledTime = calendar.nextDate(after: .now,
                                              matching: components,
                                              matchingPolicy: .nextTime)!
        
        self.startTime = scheduledTime
        self.endTime = scheduledTime.addingTimeInterval(FastingPlan.intermediate.fastingPeriod * 60 * 60)
    }
    
    func toggleState() {
        state = state == .fasting ? .feeding : .fasting
        self.startTime = Date()
        self.elapsedTime = 0.0
    }
    
    func track() {
        guard state != .notStarted else { return }
        self.isElapsed = endTime >= Date()
        self.elapsedTime += 1
        
        let totalTime = state == .fasting ? fastingTime : feedingTime
        progress = (elapsedTime / totalTime * 100).rounded() / 100
    }
}
