//
//  MemeEditorViewController+CenterAreaSetup.swift
//  MemeMe
//
//  Created by Jonathan De Araújo Silva on 22/08/22.
//

import UIKit

extension MemeEditorViewController: UITextFieldDelegate {

    fileprivate func setupTextField(_ textField: UITextField, initialText: String) {
        imageView.addSubview(textField)

        let textFont = UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        UIFontMetrics(forTextStyle: .body).scaledFont(for: textFont)

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(lessThanOrEqualTo: imageView.widthAnchor, constant: -24).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true

        textField.textAlignment = .center
        textField.text = initialText
        textField.autocapitalizationType = .allCharacters
        textField.adjustsFontSizeToFitWidth = true
        textField.defaultTextAttributes = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.strokeWidth: -5.0,
        ]
        textField.delegate = self
    }

    func setupCenterAreaAndAttachTo(container: UIStackView) {
        imageView = UIImageView(frame: container.bounds)
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(imageView)
        imageView.backgroundColor = .black

        imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.8).isActive = true
        imageView.widthAnchor.constraint(equalTo: container.widthAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true

        topText = UITextField(frame: imageView.frame)
        setupTextField(topText, initialText: MemeEditorViewController.TOP_TEXT)
        topText.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 24).isActive = true

        bottomText = UITextField(frame: imageView.frame)
        setupTextField(bottomText, initialText: MemeEditorViewController.BOTTOM_TEXT)
        bottomText.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -24).isActive = true
    }

    @objc func keyboardWillAppear(_ notification: Notification) {
        if !isKeyboardOpen && bottomText.isEditing {
            isKeyboardOpen = true
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            view.frame.origin.y -= keyboardSize.cgRectValue.height
        }
    }

    @objc func keyboardWillDisappear(_ notification: Notification) {
        if isKeyboardOpen && bottomText.isEditing {
            isKeyboardOpen = false
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
            view.frame.origin.y += keyboardSize.cgRectValue.height
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Generate a new meme image every time the text changes to avoid missing changes to the text
        // after the image was selected already.
        generateMemedImage()
        return true
    }
}

