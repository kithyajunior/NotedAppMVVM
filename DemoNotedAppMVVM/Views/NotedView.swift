//
//  NotedView.swift
//  DemoNotedAppMVVM
//
//  Created by Meang Atithkithya on 25/9/25.
//

import SwiftUI
import CoreData

struct NotedView: View {
    
    @EnvironmentObject var viewModel: DemoNotedAppViewModel
    @State private var searchText = ""
    @State private var selectedNote: DemoNotedAppEntity?
    
    var groupedByDate: [Date: [DemoNotedAppEntity]] {
        let calendar = Calendar.current
        return Dictionary(grouping: viewModel.notes) { noteEntity in
            let dateComponents = calendar.dateComponents([.year, .month, .day], from: noteEntity.createDate ?? Date())
            return calendar.date(from: dateComponents) ?? Date()
        }
    }
    
    var headers: [Date] {
        groupedByDate.keys.sorted(by: >)
    }
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedNote) {
                ForEach(headers, id: \.self) { header in
                    Section(header: Text(header, style: .date)) {
                        ForEach(groupedByDate[header] ?? []) { note in
                            NavigationLink(value: note) {
                                ListNotedView(note: note)
                            }
                        }
                        .onDelete { indexSet in
                            deleteNote(in: header, at: indexSet)
                        }
                    }
                }
            }
            .id(UUID())
            .navigationTitle("Notes")
            .searchable(text: $searchText)
            .onChange(of: searchText) {
                viewModel.searchNotes(with: searchText)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        createNewNote()
                    } label: {
                        Image(systemName: "note.text.badge.plus")
                            .foregroundColor(Color.primary)
                    }
                }
            }
            
        } detail: {
            if let selectedNote {
                EditsNotedView(note: selectedNote)
                    .id(selectedNote.objectID)
            } else {
                Text("Select a Note.")
            }
        }
    }
    
    private func createNewNote() {
        selectedNote = viewModel.createNote()
    }
    
    private func deleteNote(in header: Date, at offsets: IndexSet) {
        offsets.forEach { index in
            if let noteToDelete = groupedByDate[header]?[index] {
                if noteToDelete == selectedNote {
                    selectedNote = nil
                }
                viewModel.deleteNote(noteToDelete)
            }
        }
    }
}

#Preview {
    NotedView()
}
