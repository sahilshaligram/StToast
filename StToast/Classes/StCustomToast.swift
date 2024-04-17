import Foundation
import UIKit

public class StCustomToast {
    
    //MARK: - Variables -
    let controller: UIViewController!
    let type: ToastType!
    let position: ToastPosition!
    let backgroundColor: UIColor!
    let borderColor: UIColor!
    let toast: ToastView!
    let delay: TimeInterval!
    var containerTop: NSLayoutConstraint!
    var containerYCenter: NSLayoutConstraint!
    var containerBottom: NSLayoutConstraint!
    var containerLeading: NSLayoutConstraint!
    var containerTrailing: NSLayoutConstraint!
    var containerHeight: NSLayoutConstraint!
    
    
    //MARK: - Initialize the class -
    public init(controller: UIViewController!, msg: String!, font: UIFont? = .systemFont(ofSize: 18), backgroundColor: UIColor? = .clear, textColor: UIColor? = .systemRed, borderColor: UIColor? = .systemRed, type: ToastType? = .error, position: ToastPosition? = .top, delay: TimeInterval? = 1) {
        self.controller = controller
        self.type = type
        self.position = position
        self.backgroundColor = backgroundColor == .systemRed ? type?.bgColor : backgroundColor
        self.borderColor = borderColor == .systemRed ? type?.bgColor : borderColor
        self.delay = delay
        toast = ToastView(msg: msg, font: font, textColor: textColor == .systemRed ? type?.bgColor : textColor, type: type, position: position)
        toast.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - Set the view on screen -
    func setConstraints() {
        controller.view.addSubview(toast)
        toast.backgroundColor = backgroundColor
        toast.layer.borderColor = borderColor.cgColor
        toast.layer.borderWidth = 1.5
        toast.layer.cornerRadius = 8
        if #available(iOS 11.0, *) {
            containerLeading = toast.leadingAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.leadingAnchor, constant: 8)
        }
        containerLeading.isActive = true
        if #available(iOS 11.0, *) {
            containerTrailing = toast.trailingAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        }
        containerTrailing.isActive = true
        containerHeight = toast.heightAnchor.constraint(equalToConstant: 55)
        containerHeight.isActive = true
        if position == .top {
            if #available(iOS 11.0, *) {
                containerTop = toast.topAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.topAnchor, constant: -120)
            }
            containerTop.isActive = true
        } else if position == .center {
            containerYCenter = toast.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor, constant: 0)
            containerYCenter.isActive = true
        } else {
            if #available(iOS 11.0, *) {
                containerBottom = toast.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor, constant: 120)
            }
            containerBottom.isActive = true
        }
    }
    
    //MARK: - Animate the toast -
    func animateInOut() {
        if self.position == .top {
            self.containerTop.constant += 150
        } else {
            self.containerBottom.constant -= 200
        }
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.controller.view.layoutIfNeeded()
        }, completion: { _ in
            if self.position == .top {
                self.containerTop.constant -= 150
            } else {
                self.containerBottom.constant += 200
            }
            UIView.animate(withDuration: 1, delay: self.delay, options: .curveEaseInOut) {
                self.controller.view.layoutIfNeeded()
            } completion: { _ in
                self.toast.removeFromSuperview()
            }
        })
    }
    
    //MARK: - Initialize the toast Animation -
    public func show() {
        if position != .center {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
                self.setConstraints()
            } completion: { isCompleted in
                if isCompleted {
                    self.animateInOut()
                }
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
                self.setConstraints()
            } completion: { isCompleted in
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                for _ in 0...9 {
                    generator.impactOccurred()
                }
                self.toast.shake {
                    UIView.animate(withDuration: 1, delay: 0.0, options: .curveEaseInOut) {
                        self.controller.view.layoutIfNeeded()
                        self.toast.alpha = 0
                    } completion: { _ in
                        self.toast.removeFromSuperview()
                    }
                }
            }
        }
    }
}

//MARK: - Toast View Class -
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
