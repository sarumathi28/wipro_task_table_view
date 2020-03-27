//
//  TableViewTestTests.swift
//  TableViewTestTests
//
//  Created by Guest User on 09/03/2020.
//  Copyright © 2020 Guest User. All rights reserved.
//

import XCTest
@testable import TableViewTest

class TableViewTestTests: XCTestCase {
    var tableViewController: TableViewController!
    var viewModel: TableViewModel!

    override func setUp() {
        tableViewController = TableViewController()
        viewModel = TableViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testHasATableView() {
        XCTAssertNotNil(tableViewController.tableView)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(tableViewController.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(tableViewController.responds(to: #selector(tableViewController.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(tableViewController.responds(to: #selector(tableViewController.tableView(_:cellForRowAt:))))
    }

    func testJSONMapping() throws {
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else{
                   XCTFail("URL not working")
                   return
               }
        print(url)
        
        self.viewModel.getData(onSuccess: {
            print("Success")
            XCTAssertEqual(self.viewModel.data?.title, "About Canada")

        }) { onFailure in
            print("Failure")
        }
    }
    
}
