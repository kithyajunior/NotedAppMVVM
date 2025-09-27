## DemoNotedAppMVVM — SwiftUI + MVVM + Core Data
A tiny notes app showcasing MVVM, unidirectional data flow, and local persistence.

### Features
- List notes (title + timestamp)
- Add / Edit a note (title + description)
- Delete notes (swipe or toolbar)
- Core Data storage (async/await), Combine-friendly, unit-tested repository

### Setup steps
1) **Create the Xcode project**: iOS App → Name: `Your name` → Interface: SwiftUI → Language: Swift → Storage: **include Core Data unchecked** (we provide our own stack).
2) **Add Core Data model**: File → New → File… → Data Model → Name: `Your name` (project adds `Your name.xcdatamodeld`).
3) **Inside the model**, create an **Entity** named `Note` with attributes:
   - `id: UUID` (Required)
   - `title: String` (Optional = **No**)
   - `content: String` (Optional = **Yes**, default empty)
   - `createdDate: Date` (Required)

---
