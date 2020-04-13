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
    var viewModel: TableViewModel!

    override func setUp() {
        viewModel = TableViewModel()
        var array = [TableModel.TableCellData]()
        let title = "USA"
        array.append(TableModel.TableCellData(title: "Flag", description: nil, imageHref: nil))
        array.append(TableModel.TableCellData(title: "Transportation", description: "Transportation Transportation Transportation Transportation Transportation", imageHref: nil))
        let dataMdl = TableModel(title: title, rows: array)
        viewModel.updateData(dataMdl: dataMdl)

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetTitle(){
        XCTAssertTrue(viewModel.getTitle() == "USA")
    }
    
    func testGetNumberOfRows(){
        XCTAssertTrue(viewModel.getNumberOfRows() == 2)
    }
    
    func testGetData(){
        let firstData = viewModel.dataToShow[0]
        let temp = TableModel.TableCellData(title: "Flag", description: nil, imageHref: nil)
        XCTAssertTrue(firstData == temp)
    }
    
}
