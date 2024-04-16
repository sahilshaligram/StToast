//
//  StToastView.swift
//  StToast
//
//  Created by Sahil Thaker on 17/04/24.
//

import Foundation
import UIKit

class ToastView: UIView {
    
    //MARK: - Variables -
    let lbl: UILabel!
    let msg: String!
    let type: ToastType!
    let position: ToastPosition!
    let font: UIFont!
    let textColor: UIColor!
    
    
    //MARK: - Initialize the toast view -
    init(msg: String!, font: UIFont!, textColor: UIColor!, type: ToastType!, position: ToastPosition!) {
        self.lbl = UILabel()
        self.msg = msg
        self.type = type
        self.position = position
        self.font = font
        self.textColor = textColor
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth - 32, height: 55))
        self.lbl.frame = self.bounds
        setLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Set the message in toast -
    func setLabel() {
        lbl.text = msg
        lbl.font = font
        lbl.textAlignment = .center
        lbl.textColor = textColor
        addSubview(lbl)
    }
}
