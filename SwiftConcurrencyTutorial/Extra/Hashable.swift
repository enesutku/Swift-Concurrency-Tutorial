// Created by Enes UTKU

import SwiftUI

struct MyCustomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct Hashable: View {
    
    let data: [MyCustomModel] = [
        MyCustomModel(title: "ONE"),
        MyCustomModel(title: "TWO"),
        MyCustomModel(title: "THREE"),
        MyCustomModel(title: "FOUR"),
        MyCustomModel(title: "FIVE")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing:20) {
                ForEach(data) { item in
                    Text(item.title)
                        .font(.headline)
                    Text(item.id)
                        .foregroundStyle(.gray)
                        .font(.callout)
                }
            }
        }
    }
}

#Preview {
    Hashable()
}
