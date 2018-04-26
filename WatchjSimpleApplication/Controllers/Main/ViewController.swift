//
//  WatchjSimpleApplication
//
//  Created by WatchJ on 08.04.2018.
//  Copyright © 2018 WatchJ. All rights reserved.
//

import UIKit

//
enum Position {
    case TOP, BOTTOM
}

protocol ReusableHost {
    var topView: UIView! { get }
    var bottomView: UIView! { get }
    func addReusableViewController(storyboardID: String, position: Position) -> UIViewController?
}

extension UIViewController {
    class var storyboardID : String {
        return "\(self)"
    }
}
//

class ViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = addReusableViewController(storyboardID: ListUsersController.storyboardID, position: .TOP)
        let _ = addReusableViewController(storyboardID: AddUserController.storyboardID, position: .BOTTOM)
    }
}

extension ViewController: ReusableHost {
    
    func addReusableViewController(storyboardID: String, position: Position) -> UIViewController? {
        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: storyboardID)
        vc.willMove(toParentViewController: self)
        addChildViewController(vc)
        
        switch (position) {
        case .TOP:
            topView.addSubview(vc.view)
            constraintViewEqual(parentView: topView, subView: vc.view)
        case .BOTTOM:
            bottomView.addSubview(vc.view)
            constraintViewEqual(parentView: bottomView, subView: vc.view)
        }
        
        vc.didMove(toParentViewController: self)
        return vc
    }
    
    private func constraintViewEqual(parentView: UIView, subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        let constraint1 = NSLayoutConstraint(item: parentView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal,
                                             toItem: subView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0)
        let constraint2 = NSLayoutConstraint(item: parentView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal,
                                             toItem: subView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0)
        let constraint3 = NSLayoutConstraint(item: parentView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal,
                                             toItem: subView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0)
        let constraint4 = NSLayoutConstraint(item: parentView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal,
                                             toItem: subView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0)
        parentView.addConstraints([constraint1, constraint2, constraint3, constraint4])
    }
}
