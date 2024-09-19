//
//  EditPhotoViewModel.swift
//  HATestTask
//
//  Created by Viktoryia Hermanovich on 18/09/2024.
//

import SwiftUI
import PhotosUI

final class EditPhotoViewModel: NSObject, ObservableObject {
    // MARK: - Properties
    
    @Published var photoItem: PhotosPickerItem?
    @Published var selectedPhoto: UIImage?
    @Published var saveAlert = false
    @Published var isLoading: Bool = false
    
    var saveAlertText = ""
    
    // MARK: - Update Photo
    
    @MainActor
    func updatePhoto() async {
        isLoading = true
        guard let imageData = try? await photoItem?.loadTransferable(type: Data.self),
              let image = UIImage(data: imageData) else { 
            isLoading = false
            return
        }
        
        selectedPhoto = image
        photoItem = nil
        isLoading = false
    }
    
    // MARK: - Save Photo
    
    func savePhoto(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompletion(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func saveCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer?) {
        saveAlert = true
        saveAlertText = error == nil ? "Photo saved successfully" : "Unable to save photo to gallery"
    }
}
