import UIKit

class DynamicHeightCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
}
