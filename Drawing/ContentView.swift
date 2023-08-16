//
//  ContentView.swift
//  Drawing
//
//  Created by Никита Мартьянов on 16.08.23.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
        let arrowWidth = rect.width * 0.3
        
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        path.move(to: CGPoint(x: startPoint.x - arrowWidth, y: endPoint.y - arrowWidth))
        path.addLine(to: endPoint)
        path.addLine(to: CGPoint(x: startPoint.x + arrowWidth, y: endPoint.y - arrowWidth))
        
        return path
    }
}

struct AnimatedArrow: View {
    @State private var lineWidth: CGFloat = 1
    
    var body: some View {
        Arrow()
            .stroke(lineWidth: lineWidth)
            .animation(Animation.easeInOut(duration: 1).repeatForever())
            .onAppear {
                self.lineWidth = 10
            }
    }
}

struct ColorCyclingRectangle: View {
    @State private var colorOffset: Double = 0
    
    var body: some View {
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
            .frame(width: 200, height: 200)
            .offset(x: CGFloat(colorOffset))
            .animation(Animation.linear(duration: 2).repeatForever())
            .onAppear {
                self.colorOffset = 200
            }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            AnimatedArrow()
                .frame(width: 100, height: 200)
            
            ColorCyclingRectangle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
