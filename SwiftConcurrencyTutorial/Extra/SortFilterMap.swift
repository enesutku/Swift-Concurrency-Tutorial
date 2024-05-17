// Created by Enes UTKU

import SwiftUI

struct SortFilterMap: View {
    
    struct UserModel: Identifiable {
        let id = UUID().uuidString
        let name: String
        let point: Int
        let isVerified: Bool
    }
    
    class ArrayModificationViewModel: ObservableObject {
        
        @Published var dataArray: [UserModel] = []
        @Published var filteredArray: [UserModel] = []
        @Published var mappedArray: [String] = []
        
        init() {
            getUsers()
            updateFilteredArray()
        }
        
        func updateFilteredArray() {
            // Sort
            
//            filteredArray = dataArray.sorted { user1, user2 in
//                return user1.point > user2.point
//            }
            
            // Filter
            
//            filteredArray = dataArray.filter({ user in
//                return user.isVerified
//            })
            // Map
            mappedArray = dataArray.map({ user in
                return user.name
            })
            
        }
        
        func getUsers() {
            let user1 = UserModel(name: "Enes", point: 5, isVerified: true)
            let user2 = UserModel(name: "Nick", point: 0, isVerified: false)
            let user3 = UserModel(name: "John", point: 20, isVerified: true)
            let user4 = UserModel(name: "Brand", point: 50, isVerified: true)
            let user5 = UserModel(name: "Chris", point: 45, isVerified: false)
            let user6 = UserModel(name: "Joe", point: 2, isVerified: false)
            let user7 = UserModel(name: "Amanda", point: 70, isVerified: true)
            let user8 = UserModel(name: "Emily", point: 15, isVerified: true)
            let user9 = UserModel(name: "Jason", point: 25, isVerified: false)
            let user10 = UserModel(name: "Steve", point: 100, isVerified: true)
            
            self.dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
            user10,
            ])
        }
        
    }
    
    var body: some View {
        
        @StateObject var vm = ArrayModificationViewModel()
        
        ScrollView {
            VStack(spacing: 10) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                Text(name)
                        .font(.title)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.point)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(.blue)
//                    .clipShape(.rect(cornerRadius: 10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    SortFilterMap()
}
