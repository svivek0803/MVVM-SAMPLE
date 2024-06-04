//
//  LoadingOverlay.swift
//  ExpatLand
//
//  Created by User on 02/12/21.
//  Copyright © 2021 cypress. All rights reserved.
//

import UIKit

class LoadingOverlay {
    
        var blurEffectView = VisualEffectView()
        var loadingIndicator = UIImageView()
        var bgView = UIView()
        

    
    class var shared: LoadingOverlay {
            struct Static {
                static let instance: LoadingOverlay = LoadingOverlay()
            }
            return Static.instance
        }
    
    func showOverlay() {
        let view = UIApplication.shared.windows.first { $0.isKeyWindow }
        guard view != nil else { return }
        bgView.frame = view!.bounds
        bgView.backgroundColor = UIColor(named: Constants.ColorName.appBaseBaltic.rawValue)?.withAlphaComponent(0.03)
        bgView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
        
 
        let  blurEffectView = VisualEffectView(frame: view!.bounds)

        blurEffectView.colorTint = UIColor(named: Constants.ColorName.appBaseBaltic.rawValue)?.withAlphaComponent(0.03)
        blurEffectView.colorTintAlpha = 0.1
        blurEffectView.blurRadius = 5
        blurEffectView.scale = 1
        blurEffectView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
        self.blurEffectView = blurEffectView
        bgView.addSubview(blurEffectView)
        bgView.addSubview(loadingIndicator)
        

        loadingIndicator.contentMode = .scaleAspectFit
        loadingIndicator.frame.size = Constants.animatingImageViewSize
        loadingIndicator.center = CGPoint(x: bgView.bounds.width / 2, y: bgView.bounds.height / 2)
        bgView.bringSubviewToFront(loadingIndicator)
        view?.addSubview(bgView)
        setAnimatingImage()
        
    }

        func hideOverlayView() {
            loadingIndicator.removeFromSuperview()
            self.blurEffectView.removeFromSuperview()
            bgView.removeFromSuperview()
       }
    
    private func setAnimatingImage() {
        loadingIndicator.setGifWith(name: Constants.GifName.loading.rawValue)
        loadingIndicator.animationDuration = Constants.loadingViewGifAnimatingDuration
        loadingIndicator.animationRepeatCount = 0

        loadingIndicator.startAnimating()
    }
}
