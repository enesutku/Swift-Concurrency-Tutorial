// Created by Enes UTKU

import SwiftUI

struct WeakSelf: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
        NavigationView(content: {
            NavigationLink(destination: WeakSelfSecondScreen()) {
                VStack {
                    Text("Navigate")
                }
            }
                .navigationTitle("Screen 1")
        })
        .overlay {
            Text("\(count ?? 0)")
                .padding()
                .background(Color(.systemGreen))
        }
    }
}

class WeakSelfSecondScreenModel: ObservableObject {
    
    @Published var data: String? = nil
    
    init() {
        print("INITILIZED")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITILIZED")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        data = "New Data!"
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .foregroundStyle(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

#Preview {
    WeakSelf()
}
