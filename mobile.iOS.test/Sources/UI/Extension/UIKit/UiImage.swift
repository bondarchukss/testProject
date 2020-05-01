import Foundation
import UIKit

extension UIImage {
    public func textToImage(drawText text: String, atPoint point: CGPoint,
                            withAttributes: [NSAttributedString.Key: AnyObject]) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: self.size))
        let rect = CGRect(origin: point, size: self.size)
        text.draw(in: rect, withAttributes: withAttributes)
        guard let returnedPicture = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return self
        }
        UIGraphicsEndImageContext()
        return returnedPicture
    }
}
