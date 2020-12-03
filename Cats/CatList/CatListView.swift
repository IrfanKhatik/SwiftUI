//
//  CatListView.swift
//  Cats
//
//  Created by Irfan Khatik on 28/11/20.
//

import SwiftUI
import CoreData

struct CatListView: View {
    
    @ObservedObject private var viewModel = CatListViewModel()
    
    var body: some View {
        
        NavigationView {
            List(self.viewModel.storedCats, id: \.self) { catItem in
                CatItemCell(catItem: catItem)
            }
            .navigationBarTitle("Cats")
        }
        .onAppear {
            self.viewModel.getCatList()
        }
        .alert(isPresented: $viewModel.showAlert) { () -> Alert in
            Alert(title: Text(viewModel.alertMessage))
        }
    }
}

struct CatItemCell: View {
    var catItem: CatItem
    var body: some View {
        let detailView = CatDetailView(catItem: catItem)
        
        NavigationLink(destination: detailView) {
            Text(catItem.name?.capitalized ?? "")
        }
    }
}

#if DEBUG
struct CatListView_Previews: PreviewProvider {
    static var previews: some View {
        CatListView()
    }
}
#endif
