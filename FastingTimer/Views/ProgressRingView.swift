//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by Амир Кайдаров on 1/16/23.
//

import SwiftUI

struct ProgressRingView: View {
    
    @State var progress = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(AngularGradient(
                    gradient: Gradient(
                        colors: Colors.gradient),
                    center: .center),
                        style: StrokeStyle(lineWidth: 15.0,
                                           lineCap: .round,
                                           lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeOut(duration: 1.0), value: progress)
            
            VStack (spacing: 30) {
                VStack (spacing: 5) {
                    Text("Elapsed Time")
                        .opacity(0.7)
                    Text("0.0")
                        .font(.title)
                        .fontWeight(.bold)
                }
                .padding(.top)
                
                VStack (spacing: 5) {
                    Text("Remaining Time")
                        .opacity(0.7)
                    Text("0.0")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onAppear {
            progress = 1
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRingView()
    }
}
