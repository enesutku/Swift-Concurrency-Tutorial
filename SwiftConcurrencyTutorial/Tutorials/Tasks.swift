// Created by Enes UTKU

import SwiftUI

class TasksViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var image2: UIImage? = nil
    
    func fetchImage() async {
        do {
            guard let url = URL(string: "https://picsum.photos/600") else { return }
            let (data, response) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                self.image = UIImage(data: data)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchImage2() async {
        do {
            guard let url = URL(string: "https://picsum.photos/600") else { return }
            let (data, _) = try await URLSession.shared.data(from: url)
            await MainActor.run(body: {
                self.image2 = UIImage(data: data)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

struct Tasks: View {
    
    @StateObject private var viewModel = TasksViewModel()
    
    var body: some View {
        VStack(spacing: 40, content: {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
            if let image2 = viewModel.image {
                Image(uiImage: image2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        })
        .onAppear {
            Task {
                print(Task.currentPriority)
                await viewModel.fetchImage()
            }
            Task {
                print(Task.currentPriority)
                await viewModel.fetchImage2()
            }
            
//            Task(priority: .low) {
//                print("Low: \(Task.currentPriority.rawValue)")
//            }
//            
//            Task(priority: .medium) {
//                print("Medium: \(Task.currentPriority.rawValue)")
//            }
//            
//            Task(priority: .high) {
//                print("High: \(Task.currentPriority.rawValue)")
//            }
//            
//            Task(priority: .background) {
//                print("Background: \(Task.currentPriority.rawValue)")
//            }
//            
//            Task(priority: .userInitiated) {
//                print("User Initiated: \(Task.currentPriority.rawValue)")
//            }
            
        }
    }
}

#Preview {
    Tasks()
}
