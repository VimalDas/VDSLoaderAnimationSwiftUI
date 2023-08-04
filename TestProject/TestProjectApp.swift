//
//  TestProjectApp.swift
//  TestProject
//
//  Created by Vimal Das on 04/08/23.
//

import SwiftUI

@main
struct TestProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Rectangle()
                    .background(Color.black)
                    .ignoresSafeArea()
                VDSAnimationSwiftUI(numberOfTriangles: 4, numberOfSquares: 3)
                    .frame(width: 120, height: 120)

            }
        }
    }
}
