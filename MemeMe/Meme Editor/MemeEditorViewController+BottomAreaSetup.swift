//
//  MemeEditorViewController+BottomAreaSetup.swift
//  MemeMe
//
//  Created by Jonathan De Araújo Silva on 22/08/22.
//

import UIKit

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func setupBottomAreaAndAttachTo(container: UIStackView) {
        let stack = UIStackView(frame: container.frame)
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(stack)
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 64)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .lightGray

        cameraButton = UIButton()
        cameraButton.setImage(UIImage(systemName: "camera.fill"), for: .normal)
        cameraButton.tintColor = .systemBlue

        albumButton = UIButton()
        albumButton.setTitle("Album", for: .normal)
        albumButton.setTitleColor(.systemBlue, for: .normal)

        stack.addArrangedSubview(cameraButton)
        stack.addArrangedSubview(albumButton)

        cameraButton.addAction(UIAction(handler: cameraPressed), for: .touchUpInside)
        albumButton.addAction(UIAction(handler: albumButtonPressed), for: .touchUpInside)
    }

    private func cameraPressed(_: UIAction) {
        openImagePicker(type: .camera)
    }

    private func albumButtonPressed(_: UIAction) {
        openImagePicker(type: .photoLibrary)
    }

    private func openImagePicker(type:  UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            generateMemedImage()
            shareButton.isEnabled = true
            picker.dismiss(animated: true)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func saveMeme() {
        if let topText = topText.text, let bottomText = bottomText.text, let image = imageView.image {
            meme = Meme(topText: topText, bottomText: bottomText, image: image, memedImage: memedImage)
        }
    }

    func generateMemedImage() {
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, true, 0)
//        These lines of code are not working as expected. Camera image is too big for the texts.
//        Had to replace with imageView.layer.render call to have the image correctly sized.
//        imageView.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
//        let memeImage = UIGraphicsGetImageFromCurrentImageContext()!
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        memedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
}
