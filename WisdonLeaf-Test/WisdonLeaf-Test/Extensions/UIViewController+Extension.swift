//
//  UIViewController+Extension.swift
//  WisdonLeaf-Test
//
//  Created by manoj kumar on 11/08/20.
//  Copyright © 2020 Manoj Kumar M. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK: - Helper Methods
    func showAlert(_ title: String, message: String, style: UIAlertController.Style = .alert, actionList:[UIAlertAction] = [UIAlertAction(title: "OK", style: .default, handler: nil)] ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actionList {
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
}
