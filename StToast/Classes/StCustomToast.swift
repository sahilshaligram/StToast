import Foundation
import UIKit

public class StCustomToast {
    
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
    /// - Parameter message: Set the message to be displayed in the toast.
    /// - Parameter font - optional: You can set any custom font you are using for your app (default is systemFont(ofSize: 18)).
    /// - Parameter backgroundColor - optional: You can yout desired backgroundColor (default is clear).
    /// - Parameter textColor - optional: Custom text color for your toast message (default is the color from toast selected type).
    /// - Parameter borderColor - optional: Custom border color can be set on this property (default is same as the textColor).
    /// - Parameter type - optional: Default added toast style types options - (error, warning, success) (default set type is error).
    /// - Parameter position - optional: Default position options to show toast on the screen options - (top, center, bottom) (default is top).
    /// - Parameter delay - optional: custom time interval for the toast to keep displayed on screen (default is 1)
    public init(message: String!, font: UIFont? = .systemFont(ofSize: 18), backgroundColor: UIColor? = .clear, textColor: UIColor? = .systemRed, borderColor: UIColor? = .systemRed, type: ToastType? = .error, position: ToastPosition? = .top, delay: TimeInterval? = 1) {
        self.controller = UIApplication.shared.delegate?.window??.rootViewController
        self.type = type
        self.position = position
        self.backgroundColor = backgroundColor == .systemRed ? type?.bgColor : backgroundColor
        self.borderColor = borderColor == .systemRed ? type?.bgColor : borderColor
        self.delay = delay
        toast = ToastView(message: message, font: font, textColor: textColor == .systemRed ? type?.bgColor : textColor, type: type, position: position)
        toast.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //MARK: - Set the view on screen -
    /// - Starts to set constraints to the toast.
    /// - Prepares the initial toast for animation.
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
        switch position {
        case .top:
            containerTop = toast.topAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.topAnchor, constant: -120)
            containerTop.isActive = true
        case .center:
            containerYCenter = toast.centerYAnchor.constraint(equalTo: controller.view.centerYAnchor, constant: 0)
            containerYCenter.isActive = true
        case .bottom:
            containerBottom = toast.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor, constant: 120)
            containerBottom.isActive = true
        default:
            containerTop = toast.topAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.topAnchor, constant: -120)
            containerTop.isActive = true
        }
    }
    
    //MARK: - Animate the toast -
    /// - Animates the toast to make it slide from the selected direction.
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
    /// - This will be called by the developer to decide when to show the toast.
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
