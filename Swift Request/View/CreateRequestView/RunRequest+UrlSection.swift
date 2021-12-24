//
//  RunRequest+UrlSection.swift
//  Swift Request
//
//  Created by Jonathan Dowdell on 12/21/21.
//

import SwiftUI

// MARK: URL Section
extension RunRequestView {
    
    var urlSection: some View {
        Section {
            HStack {
                Image(systemName: "pencil")
                    .padding(.trailing, 10)
                    .foregroundColor(viewModel.title.isEmpty ? Color.gray : Color.accentColor)
                Text("Title")
                    .foregroundColor(Color.gray)
                Spacer()
                TextField("Optional", text: $viewModel.title)
                    .multilineTextAlignment(.trailing)
                    .disableAutocorrection(true)
                    .padding(.trailing, 10)
            }
            HStack {
                Image(systemName: "personalhotspot")
                    .padding(.trailing, 10)
                    .foregroundColor(viewModel.url.isEmpty ? Color.gray : Color.accentColor)
                Text("URL")
                    .foregroundColor(Color.gray)
                Spacer()
                TextField("Localhost:3000", text: $viewModel.url)
                    .multilineTextAlignment(.trailing)
                    .disableAutocorrection(true)
                    .padding(.trailing, 10)
            }
            Picker(selection: $viewModel.methodType) {
                ForEach(viewModel.methodOptions, id: \.self) {
                    MethodItem(method: $0)
                }
            } label: {
                HStack {
                    Image(systemName: "bolt.horizontal")
                        .padding(.trailing, 10)
                        .foregroundColor(Color.accentColor)
                    Text("Method")
                        .foregroundColor(.gray)
                }
            }
            
            ForEach(viewModel.urlParams, id: \.self) {
                ParamItem($0)
            }
            .onDelete(perform: removeURLQueryParam)
            
            Button(action: addURLQueryParam) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    
                    Spacer()
                    
                    Text("Add URL Param")
                }
                .foregroundColor(.blue)
                .padding(.trailing, 10)
            }

        } header: {
            Text("URL")
        }
    }
    
    private func addURLQueryParam() {
        let queryParam = ParamEntity(context: moc)
        queryParam.type = ParamType.URL.rawValue
        queryParam.active = true
        withAnimation {
            viewModel.urlParams.append(queryParam)
        }
    }
    
    private func removeURLQueryParam(_ offSet: IndexSet) {
        guard let element = offSet.first else { return }
        viewModel.urlParams.remove(at: element)
    }
}

struct CreateRequest_UrlSection_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RunRequestView(viewModel: RunRequestViewModel(historyUpdateId: .constant(UUID())))
                .environment(\.colorScheme, .light)
            
            RunRequestView(viewModel: RunRequestViewModel(historyUpdateId: .constant(UUID())))
                .environment(\.colorScheme, .dark)
        }
    }
}