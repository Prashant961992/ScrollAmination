//
//  ViewController.swift
//  ScrollAmination
//
//  Created by Prashant Prajapati on 10/01/23.
//

import UIKit

struct ListImages {
    var background: String!
    var front: String!
}

class ViewController: UIViewController {
    var listOfImages = [
        ListImages(background: "0_bg", front: "0_front"),
        ListImages(background: "1_bg", front: "1_front"),
        ListImages(background: "2_bg", front: "2_front"),
        ListImages(background: "3_bg", front: "3_front"),
        ListImages(background: "4_bg", front: "4_front"),
        ListImages(background: "5_bg", front: "5_front"),
        ListImages(background: "6_bg", front: "6_front"),
        ListImages(background: "7_bg", front: "7_front"),
        ListImages(background: "8_bg", front: "8_front"),
        ListImages(background: "9_bg", front: "9_front"),
    ]
    
    @IBOutlet private weak var pageFrameView: UIView! {
        willSet {
            self.addChild(self.pageMaster)
            newValue.addSubview(self.pageMaster.view)
            newValue.fitToSelf(childView: self.pageMaster.view)
            self.pageMaster.didMove(toParent: self)
        }
    }
    
    @IBOutlet private weak var pageControl: UIPageControl!
    
    @IBOutlet private weak var switchInfiniteButton: UIButton!
    
    private let pageMaster = PageMaster([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupPageViewController()
    }
    
    @IBAction private func didTapInfiniteButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        self.pageMaster.isInfinite.toggle()
    }
}


// MARK: - Setup
extension ViewController {
    
    private func setupPageViewController() {
        self.pageMaster.pageDelegate = self
        var vcList = [UIViewController]()

        for item in listOfImages {
            vcList.append(self.generateViewController(images: item))
        }

        self.pageControl.numberOfPages = vcList.count
        self.pageMaster.setup(vcList)
    }
    
    private func generateViewController(images: ListImages) -> UIViewController {
        let vc = UIViewController()

        var smallImageView : UIImageView!
        smallImageView = UIImageView(frame: CGRect(x: 15, y: self.view.bounds.size.height - 270, width: self.view.bounds.size.width - 30, height: 200))
        smallImageView.contentMode =  UIView.ContentMode.scaleAspectFill
        smallImageView.clipsToBounds = true
        smallImageView.image = UIImage(named: images.front)

        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: images.background)
        imageView.center = view.center
        vc.view.addSubview(imageView)
        vc.view.addSubview(smallImageView)
        vc.view.bringSubviewToFront(smallImageView)

        return vc
    }
}

// MARK: - PageMasterDelegate
extension ViewController: PageMasterDelegate {
    
    func pageMaster(_ master: PageMaster, didChangePage page: Int) {
        self.pageControl.currentPage = page
    }
}
