//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by Амир Кайдаров on 1/16/23.
//

import SwiftUI

struct ProgressRingView: View {
    
    @EnvironmentObject var viewModel : FastingViewModel
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            Circle()
                .trim(from: 0.0, to: min(viewModel.progress, 1.0))
                .stroke(AngularGradient(
                    gradient: Gradient(
                        colors: Colors.gradient),
                    center: .center),
                        style: StrokeStyle(lineWidth: 15.0,
                                           lineCap: .round,
                                           lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeOut(duration: 1.0), value: viewModel.progress)
            
            VStack (spacing: 30) {
                if viewModel.state == .notStarted {
                    VStack (spacing: 5) {
                        Text("Upcoming Fast")
                            .opacity(0.7)
                        Text("\(viewModel.plan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                } else {
                    VStack (spacing: 5) {
                        Text("Elapsed Time (\(viewModel.progress.formatted(.percent)))")
                            .opacity(0.7)
                        Text(viewModel.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    
                    VStack (spacing: 5) {
                        Text(viewModel.isElapsed
                             ? "Remaining Time"
                             : "Extra Time")
                        .opacity(0.7)
                        Text(viewModel.endTime, style: .timer)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onReceive(timer) { _ in
            viewModel.track()
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView()
            .environmentObject(FastingViewModel())
    }
}
