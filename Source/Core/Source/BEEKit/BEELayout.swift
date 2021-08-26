import UIKit

public struct BEEViewLayoutSize {

    public let widthDimension: BEEViewLayoutDimension!
    public let heightDimension: BEEViewLayoutDimension!

    public init(widthDimension width: BEEViewLayoutDimension,
                heightDimension height: BEEViewLayoutDimension) {
        self.widthDimension = width
        self.heightDimension = height
    }

    public func size(view: UIView, maxSize: CGSize) -> CGSize {
        var size = maxSize

        switch widthDimension {
            case let .fractionalWidth(dimension): size.width = size.width * dimension
            case let .fractionalHeight(dimension): size.width = size.height * dimension
            case let .absolute(dimension): size.width = dimension
            case let .estimated(dimension): size.width = dimension
            default: break
        }

        switch heightDimension {
            case let .fractionalWidth(dimension): size.height = size.width * dimension
            case let .fractionalHeight(dimension): size.height = size.height * dimension
            case let .absolute(dimension): size.height = dimension
            case let .estimated(dimension): size.height = dimension
            default: break
        }

        // Fixed width
        if !widthDimension.isEstimated && heightDimension.isEstimated {
            let tempConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size.width)
            view.addConstraint(tempConstraint)
            size = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            view.removeConstraint(tempConstraint)
        }

        // Fixed height
        if widthDimension.isEstimated && !heightDimension.isEstimated {
            let tempConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: size.height)
            view.addConstraint(tempConstraint)
            size = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            view.removeConstraint(tempConstraint)
        }

        // Dynamic size
        if widthDimension.isEstimated && heightDimension.isEstimated {
            size = view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        }

        return size
    }
}

public enum BEEViewLayoutDimension {

    case none
    case fractionalWidth(_ fractionalWidth: CGFloat)
    case fractionalHeight(_ fractionalHeight: CGFloat)
    case absolute(_ absoluteDimension: CGFloat)
    case estimated(_ estimatedDimension: CGFloat)

    public var isEstimated: Bool {
        switch self {
        case .estimated(_): return true
        default: return false
        }
    }
}

