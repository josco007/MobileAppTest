import Foundation
import UIKit

class ImageCacheManager{
    
    internal static let instance: ImageCacheManager = ImageCacheManager()
    private var cacheImages: Dictionary<String,UIImage>!;
    
    private init() {
        cacheImages = Dictionary()
    }
    
    internal func setImageFromUrl(_ urlStr:String, placeHolder:UIImage, imageView:UIImageView, index:Int) {
        
        if (cacheImages[urlStr] != nil){
            imageView.image = cacheImages[urlStr]
            return
        }
        
        imageView.image = placeHolder
        
        if  let url = NSURL(string: urlStr) {
            URLSession.shared.dataTask(with: url as URL) { data, response, error in
                guard let data = data, error == nil else {
                    print("\nerror on download \(String(describing: error))")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    print("statusCode != 200; \(httpResponse.statusCode)")
                    return
                }
                DispatchQueue.main.async {
                    print("\ndownload completed \(url.lastPathComponent!)")
                    self.cacheImages[urlStr] = UIImage(data: data)!;
                    if (imageView.tag != index){
                        return
                    }
                    imageView.image  = UIImage(data: data)!
                }
            }.resume()
        }
    }
}
