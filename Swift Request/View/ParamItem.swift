//
//  ParamItem.swift
//  Swift Request
//
//  Created by Jonathan Dowdell on 12/20/21.
//

import SwiftUI

struct ParamItem: View {
    
    private var queryParam: ParamEntity
    
    @State private var active: Bool
    
    @Environment(\.managedObjectContext) var moc
    
    init(_ queryParam: ParamEntity) {
        self.queryParam = queryParam
        self.active = queryParam.active
    }
    
    private var key: Binding<String> {
        .init {
            return queryParam.wrappedKey
        } set: { newValue in
            queryParam.key = newValue
        }
    }
    
    private var value: Binding<String> {
        .init {
            return queryParam.wrappedValue
        } set: { newValue in
            queryParam.value = newValue
        }
    }
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    queryParam.active.toggle()
                    active.toggle()
                }
            } label: {
                Image(systemName: active ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(.blue)
            }
            .buttonStyle(.plain)
            .padding(.trailing)
            Spacer()
            TextField("key", text: key)
                .multilineTextAlignment(.leading)
            TextField("value", text: value)
                .multilineTextAlignment(.trailing)
                .padding(.trailing, 10)
        }
    }
}

//struct QueryParamItem_Previews: PreviewProvider {
//    static var previews: some View {
//        QueryParamItem(queryParam: <#QueryParamEntity#>)
//    }
//}