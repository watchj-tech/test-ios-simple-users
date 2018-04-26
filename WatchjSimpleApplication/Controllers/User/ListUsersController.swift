//
//  WatchjSimpleApplication
//
//  Created by WatchJ on 08.04.2018.
//  Copyright © 2018 WatchJ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ListUsersController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Test data
    let dataSource = Variable<[String]>([ "First Name", "Second Name", "Third Name" ])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        dataSource.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "UserNameCell")) { row, value, cell in
                cell.textLabel?.text = value
            }.disposed(by: disposeBag)
    }
}
