//
//  CatDetailView.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import SwiftUI
import CoreData

struct CatDetailView: View {
    @ObservedObject private var viewModel: CatDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(catItem: CatItem) {
        self.viewModel = CatDetailViewModel(catItem)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Image(uiImage: self.viewModel.catImage ?? UIImage())
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                
                Spacer()
                
                Text(self.viewModel.desc.capitalized)
                    .font(.subheadline)
                    .bold()
                    .padding(10)
            }
        }
        .onAppear {
            self.viewModel.getCatDetail()
        }
        .navigationBarTitle(Text(self.viewModel.catName.capitalized), displayMode: .inline)
        .alert(isPresented: $viewModel.showErrorAlert) { () -> Alert in
            Alert(title: Text(viewModel.alertMessage))
        }
    }
}

#if DEBUG
struct CatDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CatItem")        
        let catItems = try! PersistenceController.preview.container.viewContext.fetch(request) as! [CatItem]
        NavigationView {
            if let previewItems = catItems, let catItem = previewItems.first {
                CatDetailView(catItem: catItem)
            }
        }
    }
}
#endif
