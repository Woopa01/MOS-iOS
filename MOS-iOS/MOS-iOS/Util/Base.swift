//
//  Base.swift
//  MOS-iOS
//
//  Created by 조우진 on 16/04/2019.
//  Copyright © 2019 조우진. All rights reserved.
//

import Foundation
import AsyncDisplayKit

extension ASViewController {
    open override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = Color.RED.getColor()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    @objc func showToast(msg: String, fun: (() -> Void)? = nil){
        let toast = UILabel(frame: CGRect(x: 32, y: 550, width: view.frame.size.width - 64, height: 42))
        toast.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        toast.textColor = UIColor.white
        toast.text = msg
        toast.textAlignment = .center
        toast.layer.cornerRadius = 8
        toast.clipsToBounds = true
        toast.autoresizingMask = [.flexibleTopMargin, .flexibleHeight, .flexibleWidth]
        view.addSubview(toast)
        UIView.animate(withDuration: 1, delay: 0.8, options: .curveEaseOut, animations: {
            toast.alpha = 0.0
        }, completion: { _ in
            toast.removeFromSuperview()
            fun?()
        })
    }
    
}
