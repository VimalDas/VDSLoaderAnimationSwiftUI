//
//  ContentView.swift
//  TestProject
//
//  Created by Vimal Das on 04/08/23.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Rectangle()
                .background(Color.black)
                .ignoresSafeArea()
            VDSAnimationSwiftUI(numberOfTriangles: 4, numberOfSquares: 3)
                .frame(width: 120, height: 120)

        }
    }
}

struct VDSAnimationSwiftUI: View, Animatable {
    let numberOfTriangles: Int
    let numberOfSquares: Int
    let strokeColor = LinearGradient(gradient: Gradient(colors: [.red, .orange, .red]), startPoint: .top, endPoint: .bottom)

    @State private var pathProgress: CGFloat = 0.0
    var animatableData: CGFloat {
        get { pathProgress }
        set { pathProgress = newValue }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .center) {
                ForEach(0..<numberOfTriangles, id: \.self) { index in
                    //let size = geometry.size.width / CGFloat(pow(2, Double(index)))
                    let size = geometry.size.width
                    TriangleShape()
                        .trim(from: 1-pathProgress, to: pathProgress)
                        .stroke(strokeColor)
                        .animation(Animation.easeInOut(duration: 1.5).repeatForever())
                        .frame(width: size, height: size)
                        .rotation3DEffect(Angle(degrees: Double(90 * index)), axis: (0,0,1))
                }
                
                ForEach(0..<numberOfSquares, id: \.self) { index in
                    let size = geometry.size.width / (2 * CGFloat(pow(2, Double(index))))
                    SquareShape()
                        .trim(from: 1-pathProgress, to: pathProgress)
                        .stroke(strokeColor)
                        .animation(Animation.easeInOut(duration: 1.5).repeatForever())
                        .frame(width: size, height: size)
                }
            }
            .rotationEffect(Angle(degrees: Double(180/(pathProgress == 0 ? 0.1 : pathProgress))))
            .animation(Animation.linear(duration: 3).repeatForever(autoreverses: false))
            .onAppear {
                pathProgress = 1
            }
        }
    }
}

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.size.width / 2, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.size.height))
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
            path.closeSubpath()
        }
    }
}

struct SquareShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.size.height))
            path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
            path.addLine(to: CGPoint(x: rect.size.width, y: 0))
            path.closeSubpath()
        }
    }
}




//
//struct SquareView: View {
//    private let strokeColor = Color.orange
//
//    var body: some View {
//        GeometryReader { geometry in
//            Path { path in
//                path.move(to: CGPoint(x: 0, y: 0))
//                path.addLine(to: CGPoint(x: 0, y: geometry.size.height))
//                path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
//                path.addLine(to: CGPoint(x: geometry.size.width, y: 0))
//                path.closeSubpath()
//            }
//            .stroke(strokeColor)
//        }
//    }
//}
