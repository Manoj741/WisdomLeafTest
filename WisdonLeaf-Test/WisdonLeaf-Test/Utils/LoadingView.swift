//
//  LoadingView.swift
//  WisdonLeaf-Test
//
//  Created by manoj kumar on 12/08/20.
//  Copyright © 2020 Manoj Kumar M. All rights reserved.
//

import UIKit
import Foundation

class LoadingView {

    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var labelInfo = UILabel()
    
    class var shared: LoadingView {
        struct Static {
            static let instance: LoadingView = LoadingView()
        }
        return Static.instance
    }

    //  This method applies an overlay and activity indicator with aniamtions
    public func showOverlay(view: UIView) {
        DispatchQueue.main.async {
            if view.subviews.contains(self.overlayView) {

            } else {
                self.removeOverlayBeforeApply()
                self.overlayView = UIView(frame: UIScreen.main.bounds)
                self.overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
                self.activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
                self.activityIndicator.center = self.overlayView.center
                self.overlayView.addSubview(self.activityIndicator)
                self.activityIndicator.startAnimating()
                 view.addSubview(self.overlayView)
            }
        }
    }

    // This method removes an overlay and activity indicator
    public func hideOverlayView() {
        DispatchQueue.main.async {
            if self.activityIndicator.isAnimating == true {
                self.activityIndicator.stopAnimating()
                self.overlayView.removeFromSuperview()
            }
        }
    }

    // added this method as a temporary solution to overlay issue - need to fix permanently. (called inside show overlay method)
    fileprivate func removeOverlayBeforeApply() {
        if self.activityIndicator.isAnimating == true {
            self.activityIndicator.stopAnimating()
            self.overlayView.removeFromSuperview()
        }
    }
}
