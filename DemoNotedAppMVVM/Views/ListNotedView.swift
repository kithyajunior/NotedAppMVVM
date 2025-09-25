//
//  ListNotedView.swift
//  DemoNotedAppMVVM
//
//  Created by ACLEDA on 25/9/25.
//

import SwiftUI

struct ListNotedView: View {
    var note: DemoNotedAppEntity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(note.title ?? "New Note")
                .lineLimit(1)
                .font(.title3)
                .fontWeight(.bold)
            Text(note.content ?? "No context available")
                .lineLimit(1)
                .fontWeight(.light)
        }
    }
}
