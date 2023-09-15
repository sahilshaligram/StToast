//
//  StToastView.swift
//  StToast
//
//  Created by Sahil Thaker on 16/04/24.
//

import Foundation
import UIKit

//MARK: - Toast View Class -
class ToastView: UIView {
    
    //MARK: - Variables -
    let lbl: UILabel!
    let msg: String!
    let type: ToastType!
    let position: ToastPosition!
    let font: UIFont!
    let textColor: UIColor!
    let image: UIImageView!
    private let pulseAnimation = CABasicAnimation(keyPath: "opacity")
    
    //MARK: - Initialize the toast view -
    init(msg: String!, font: UIFont!, textColor: UIColor!, type: ToastType!, position: ToastPosition!, isImage: Bool) {
        self.lbl = UILabel()
        self.image = UIImageView(frame: .zero)
        self.msg = msg
        self.type = type
        self.position = position
        self.font = font
        self.textColor = textColor
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth - 32, height: 55))
        self.lbl.frame = self.bounds
        setLabel()
        addImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removePulse()
    }
    
    //MARK: - Set the message in toast -
    func setLabel() {
        lbl.text = msg
        lbl.font = font
        lbl.textAlignment = .center
        lbl.textColor = textColor
        addSubview(lbl)
    }
    
    func addImage() {
        image.image = type.image
        image.tintColor = type.bgColor
        image.contentMode = .scaleToFill
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 35).isActive = true
        image.widthAnchor.constraint(equalToConstant: 35).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func addPulse() {
        pulseAnimation.duration = 0.6
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        image.layer.add(pulseAnimation, forKey: nil)
    }
    
    func removePulse() {
        image.layer.removeAllAnimations()
    }
}
