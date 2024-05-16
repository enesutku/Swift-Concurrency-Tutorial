// Created by Enes UTKU

import SwiftUI
import Combine

class AsyncImageDownloadLoader {
    
    let url = URL(string: "https://picsum.photos/300")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    // Download Methods
    
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
    
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
        
    }
    
}

class AsyncImageDownloadViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let loader = AsyncImageDownloadLoader()
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage() async {
        //        loader.downloadWithEscaping { [weak self] image, error in
        //            DispatchQueue.main.async {
        //                self?.image = image
        //            }
        //        }
        
        //        loader.downloadWithCombine()
        //            .sink { _ in
        //
        //            } receiveValue: { [weak self] image in
        //                DispatchQueue.main.async {
        //                    self?.image = image
        //                }
        //            }
        //            .store(in: &cancellables)
        
        let image = try? await loader.downloadWithAsync()
        self.image = image
        
    }
}

struct AsyncImageDownload: View {
    
    @StateObject private var viewModel = AsyncImageDownloadViewModel()
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

#Preview {
    AsyncImageDownload()
}
