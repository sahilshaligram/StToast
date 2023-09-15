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
