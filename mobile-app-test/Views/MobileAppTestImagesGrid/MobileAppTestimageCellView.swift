import UIKit

class MobileAppTestimageCellView: UICollectionViewCell {

    var imageView: UIImageView!
    
    override func awakeFromNib() {
        if (imageView != nil){
            return
        }
        imageView = UIImageView(frame: contentView.frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}


