import UIKit

class MobileAppTestImagesGridVC: UIViewController {

    @IBOutlet weak var mobileAppTestImagesGridView: MobileAppTestImagesGridView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:false);
        mobileAppTestImagesGridView.setImgages(images: ImagesConstants.mobileAppTestGridImages)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
