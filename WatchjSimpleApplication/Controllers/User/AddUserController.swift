//
//  WatchjSimpleApplication
//
//  Created by WatchJ on 08.04.2018.
//  Copyright © 2018 WatchJ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class AddUserController: UIViewController {

    @IBOutlet weak var addNewUserButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNewUserButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] in
                self?.showMessage("New user added")
            }).disposed(by: disposeBag)
    }
    
    private func showMessage(_ text: String) {
        let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
