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
    var httpClient: HttpClient!
    let session = MockURLSession()
    
    
    override func setUp() {
        viewModel = TableViewModel()
        httpClient = HttpClient(session: session)
        var array = [TableModel.TableCellData]()
        let title = "USA"
        array.append(TableModel.TableCellData(title: "Flag", description: nil, imageHref: nil))
        array.append(TableModel.TableCellData(title: "Transportation", description: "Transportation Transportation Transportation Transportation Transportation", imageHref: nil))
        let dataMdl = TableModel(title: title, rows: array)
        viewModel.updateData(dataMdl: dataMdl)
        
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
    
    
    func testURL() {
        
        guard let url = URL(string: viewModel.urlString) else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
    }
    
}

// Protocol for MOCK/Real
protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

//MARK: HttpClient Implementation
class HttpClient {
    
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
        
    }
    
    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
    
}

//MARK: Conform the protocol
extension URLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocol.DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

//MARK: MOCK
class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }
    
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
}
