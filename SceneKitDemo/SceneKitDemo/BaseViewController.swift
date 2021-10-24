//
//  BaseViewController.swift
//  SceneKitDemo
//
//  Created by Omnia Samy on 22/10/2021.
//

import Foundation
import UIKit
import SwiftMessages

class BaseViewController: UIViewController {
    
    func showSuccessMessage(successMessage: String) {
        
        let view = MessageView.viewFromNib(layout: .cardView)
        view.button?.isHidden = true
        view.configureTheme(.success)
        view.configureDropShadow()
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        view.configureContent(title: "Congratulation", body: successMessage)
        view.layoutMarginAdditions = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 8
        SwiftMessages.show(config: config, view: view)
    }
}
