//
//  MemeEditorViewController+TopAreaSetup.swift
//  MemeMe
//
//  Created by Jonathan De Araújo Silva on 22/08/22.
//

import UIKit
import LinkPresentation

extension MemeEditorViewController: UIActivityItemSource {
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return meme!.memedImage
    }

    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return meme!.memedImage
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = "MemeMe"
        metadata.imageProvider = NSItemProvider(object: meme!.memedImage)
        metadata.iconProvider = NSItemProvider(object: meme!.memedImage)
        return metadata
    }


    func setupTopAreaAndAttachTo(container: UIStackView) {
        let stack = UIStackView(frame: container.frame)
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.addArrangedSubview(stack)

        // Add margins [paddings] to UIStackView
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        stack.isLayoutMarginsRelativeArrangement = true

        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true
        stack.backgroundColor = .lightGray

        shareButton = UIButton(frame: stack.frame)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .systemBlue
        cancelButton = UIButton(frame: stack.frame)
        cancelButton.setTitle("cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)

        stack.addArrangedSubview(shareButton)
        stack.addArrangedSubview(cancelButton)

        shareButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 48).isActive = true

        cancelButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 48).isActive = true

        shareButton.isEnabled = false
        shareButton.addAction(UIAction(handler: shareMeme), for: .touchUpInside)
        cancelButton.addAction(UIAction(handler: cancel), for: .touchUpInside)
    }

    private func shareMeme(_: UIAction) {
        let activityController = UIActivityViewController(activityItems: [self], applicationActivities: nil)
        activityController.completionWithItemsHandler = { type, completed, returnedItems, error in
            activityController.dismiss(animated: true)
        }
        present(activityController, animated: true)
    }

    private func cancel(_: UIAction) {
        self.imageView.image = nil
        self.topText.text = MemeEditorViewController.TOP_TEXT
        self.bottomText.text = MemeEditorViewController.BOTTOM_TEXT
    }
}
