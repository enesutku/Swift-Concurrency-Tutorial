// Created by Enes UTKU

import SwiftUI

struct LongPressGesture: View {
    
    @State var isComplete: Bool = false
    
    var body: some View {
        Text(isComplete ? "Completed" : "Not Completed")
            .padding()
            .padding(.horizontal)
            .background(Color(isComplete ? .systemGreen : .systemGray5))
            .clipShape(.rect(cornerRadius: 10))
            .onLongPressGesture(minimumDuration: 3, maximumDistance: 10) {
                isComplete.toggle()
            }
    }
}

#Preview {
    LongPressGesture()
}
