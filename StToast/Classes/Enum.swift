import Foundation
import UIKit
public enum ToastType {
    case success, error, warning
    
    var bgColor: UIColor {
        switch self {
        case .success:
            return .systemGreen
        case .error:
            return .systemRed
        case .warning:
            return .systemYellow
        }
    }
    
    var image: UIImage {
        switch self {
        case .success:
            return UIImage(named: "ic_success") ?? UIImage()
        case .error:
            return UIImage(named: "ic_error") ?? UIImage()
        case .warning:
            return UIImage(named: "ic_warning") ?? UIImage()
        }
    }
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .error:
            return "Error"
        case .warning:
            return "Warning"
        }
    }
}

public enum ToastPosition {
    case top, center, bottom
}
