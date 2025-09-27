//
//  EditsNotedView.swift
//  DemoNotedAppMVVM
//
//  Created by Meang Atithkithya on 25/9/25.
//

import SwiftUI

struct EditsNotedView: View {
    
    @EnvironmentObject var vm: DemoNotedAppViewModel
    
    @State var note: DemoNotedAppEntity?
    @State private var title: String = ""
    @State private var content: String = ""
    
    @FocusState private var contentEditorInFocus: Bool
    @State private var saveWorkItem: DispatchWorkItem?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Title", text: $title, axis: .vertical)
                    .font(.title.bold())
                    .submitLabel(.next)
                    .onChange(of: title) { _ in
                        if let last = title.last, last == "\n" {
                            title.removeLast()
                            contentEditorInFocus = true
                        }
                        scheduleSave()
                    }
                NotedTextEditorView(string: $content)
                    .scrollDisabled(true)
                    .font(.title3)
                    .focused($contentEditorInFocus)
                    .onChange(of: content) { _ in
                        scheduleSave()
                    }
            }
            .padding(10)
        }
        .navigationBarTitleDisplayMode(.inline)
        .simultaneousGesture(
            TapGesture().onEnded { hideKeyboard() }
        )
        .onAppear {
            if let note = note {
                self.title = note.title ?? ""
                self.content = note.content ?? ""
            }
        }
    }
    private func scheduleSave() {
        saveWorkItem?.cancel()
        let workItem = DispatchWorkItem {
            guard let note = note else { return }
            if title.isEmpty && content.isEmpty {
                return
            }
            vm.updateNote(note, title: title, content: content)
        }
        saveWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.endEditing()
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil, from: nil, for: nil)
    }
}
