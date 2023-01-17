//
//  ContentView.swift
//  FastingTimer
//
//  Created by Амир Кайдаров on 1/16/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = FastingViewModel()
    
    private var title : String {
        switch viewModel.state {
        case .notStarted:
            return "Let's get started"
        case .fasting:
            return "You're now fasting"
        case .feeding:
            return "You're now feeding"
        }
    }
    
    private var timerLabelBegin : String {
        switch viewModel.state {
        case .notStarted:
            return "Start"
        default:
            return "Started"
        }
    }
    
    private var timerLabelEnd : String {
        switch viewModel.state {
        case .notStarted:
            return "End"
        default:
            return "Ends"
        }
    }
    
    private var buttonLabel : String {
        switch viewModel.state {
        case .fasting:
            return "End fasting"
        default:
            return "Start fasting"
        }
    }
    
    var body: some View {
        ZStack {
            Color(red:0.05,
                  green : 0.0067,
                  blue: 0.0816)
            .ignoresSafeArea()
            
            contents
        }
    }
    
    
    
    var contents : some View {
        ZStack {
            VStack (spacing: 40) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Colors.lightPurple)
                
                Text(viewModel.plan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            
            VStack (spacing: 40) {
                ProgressRingView()
                    .environmentObject(viewModel)
                
                HStack (spacing: 60) {
                    VStack (spacing: 5) {
                        Text(timerLabelBegin)
                            .opacity(0.7)
                        
                        Text(viewModel.startTime,
                             format: .dateTime
                            .weekday()
                            .hour()
                            .minute()
                            .second())
                        .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    
                    VStack (spacing: 5) {
                        Text(timerLabelEnd)
                            .opacity(0.7)
                        
                        Text(viewModel.endTime,
                             format: .dateTime
                            .weekday()
                            .hour()
                            .minute()
                            .second())
                        .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                }
                
                Button {
                    viewModel.toggleState()
                } label: {
                    Text(buttonLabel)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }
            }
            .padding()
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
