// Created by Enes UTKU

import SwiftUI

class DoCatchTryDataManager {
    
    let isActive: Bool = false
    
    func getTitle() -> (title: String?, error: Error?) {
        if isActive {
            return ("New Text", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getTitle2() -> Result<String, Error> {
        if isActive {
            return .success("New Text")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getTitle3() throws -> String {
        if isActive {
            return "New Text"
        } else {
            throw URLError(.badServerResponse)
        }
    }
    
}

class DoCatchTryViewModel: ObservableObject {
    
    @Published var text: String = "Starting Text"
    let manager = DoCatchTryDataManager()
    
    func fetchTitle() {
        /*
         let returnedValue = manager.getTitle()
         if let newTitle = returnedValue.title {
         self.text = newTitle
         } else if let error = returnedValue.error {
         self.text = error.localizedDescription
         }
         */
        /*
         let result = manager.getTitle2()
         
         switch result {
         case .success(let newTitle):
         self.text = newTitle
         case .failure(let error):
         self.text = error.localizedDescription
         }
         */
        
        do {
            let newTitle = try manager.getTitle3()
            self.text = newTitle
        } catch {
            self.text = error.localizedDescription
        }
    }
}

struct DoCatchTry: View {
    
    @StateObject private var viewModels = DoCatchTryViewModel()
    
    var body: some View {
        Text(viewModels.text)
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .frame(width: 300, height: 300)
            .background(.blue)
            .clipShape(.rect(cornerRadius: 20))
            .onTapGesture {
                viewModels.fetchTitle()
            }
    }
}

#Preview {
    DoCatchTry()
}
