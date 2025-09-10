//
//  ContentView.swift
//  LightspeedMobileTest
//
//  Created by Michael Charland on 2025-09-10.
//

import SwiftData
import SwiftUI

struct PhotoCollectionView: View {

    @Environment(\.modelContext) var modelContext
    @State private var editMode = EditMode.inactive
    @State var errorMessage: String?
    @Query(sort: \Photo.listIndex) var photos: [Photo]

    var body: some View {
        NavigationStack {
            List {
                ForEach(photos) { photo in
                    if let errorMessage {
                        Text("Error Retrieving Photo: \(errorMessage)")
                            .foregroundColor(.red)
                    } else {
                        PhotoView(photo: photo)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 0.5)
                            }
                            .background {
                                RoundedRectangle(cornerRadius: 15)
                                           .fill(Color.gray.opacity(0.05))
                            }
                    }
                }
                .onMove(perform: movePhoto)
                .onDelete(perform: deletePhoto)
            }
            .navigationBarTitle("Photo Collection")
            .navigationBarItems(leading: EditButton(), trailing: addPhotoButton)
            .environment(\.editMode, $editMode)
        }
    }
    private var addPhotoButton: some View {
        switch editMode {
        case .inactive:
            return AnyView(Button(action: addPhoto) { Text("Add Photo") })
        default:
            return AnyView(EmptyView())
        }
    }

    private func addPhoto() {
        Task {
            do {
                let last = try modelContext.fetch(FetchDescriptor<Photo>()).last?.listIndex ?? 0
                let photo = try await Connection.shared.fetchPhoto(index: last + 1)
                modelContext.insert(photo)
                save()
                errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }

    private func movePhoto(from indexSet: IndexSet, to destination: Int) {
        var mutablePhotos = photos
        mutablePhotos.move(fromOffsets: indexSet, toOffset: destination)
        for (index, photo) in mutablePhotos.enumerated() {
            photo.listIndex = index
        }
        save()
    }

    private func deletePhoto(offsets: IndexSet) {
        offsets.forEach {
            modelContext.delete(photos[$0])
        }
        save()
    }

    private func save() {
        do {
            try modelContext.save()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
