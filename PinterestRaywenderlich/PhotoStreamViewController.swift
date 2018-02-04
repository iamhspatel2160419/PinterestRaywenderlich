//
//  PhotoStreamViewController.swift

import UIKit
import AVFoundation

class PhotoStreamViewController: UICollectionViewController {
  
    var photos = Photo.allPhotos()
  
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let patternImage = UIImage(named: "Pattern") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    
    if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
    
    collectionView!.backgroundColor = UIColor.clear
    collectionView!.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 10, right: 5)
  }
  
}

extension PhotoStreamViewController {
  
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnotatedPhotoCell", for: indexPath) as! AnnotatedPhotoCell
        cell.photo = photos[indexPath.item]
        return cell
    }
  
 
  
}

extension PhotoStreamViewController : PinterestLayoutDelegate {
  // 1
  func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath,
    withWidth width: CGFloat) -> CGFloat {
      let photo = photos[indexPath.item]
      let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
    let rect  = AVMakeRect(aspectRatio: photo.image.size, insideRect: boundingRect)
      return rect.size.height
  }
  
  // 2
  func collectionView(collectionView: UICollectionView,
    heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
      let annotationPadding = CGFloat(4)
      let annotationHeaderHeight = CGFloat(17)
      let photo = photos[indexPath.item]
      let font = UIFont(name: "AvenirNext-Regular", size: 10)!
      let commentHeight = photo.heightForComment(font: font, width: width)
      let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
      return height
  }
}


