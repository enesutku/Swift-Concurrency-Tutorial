// Created by Enes UTKU

import SwiftUI

struct CustomGeometryReader: View {
    
    func getPerc(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).minX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPerc(geo: geometry) * 20),
                                                      axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: geometry.size.width * 0.6666)
//                Rectangle()
//                    .fill(.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
}

#Preview {
    CustomGeometryReader()
}
