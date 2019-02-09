import UIKit

class MobileAppTestImagesGridView: UIView , UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout{
    
    var refreshControl = UIRefreshControl()

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imagesClv: UICollectionView!
    
    private var _images: Array<String>!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("MobileAppTestImagesGridView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        imagesClv.delegate = self
        imagesClv.dataSource = self
        
        imagesClv.register(MobileAppTestimageCellView.self, forCellWithReuseIdentifier: "mobileAppTestimageCellView")
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
        imagesClv.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(sender:AnyObject)
    {
        imagesClv.reloadData()
        refreshControl.endRefreshing()
    }
    
    internal func setImgages(images:Array<String> ){
        _images = images;
    }
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mobileAppTestimageCellView", for: indexPath)
        cell.awakeFromNib()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! MobileAppTestimageCellView
        
        cell.imageView.tag = indexPath.row
        ImageCacheManager.instance.setImageFromUrl(_images[indexPath.row],
                                                   placeHolder: UIImage(named: "Loading")!,
                                                   imageView: cell.imageView,
                                                   index: indexPath.row)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}
