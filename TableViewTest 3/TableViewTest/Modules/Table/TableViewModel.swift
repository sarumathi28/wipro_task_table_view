//
//  ViewModel.swift
//  TableViewTest
//
//  Created by Guest User on 09/03/2020.
//  Copyright © 2020 Guest User. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class TableViewModel {
    var dataToShow = [TableModel.TableCellData?]()
    var data:TableModel?
    
    func getData(onSuccess: @escaping()->(), onFailure: @escaping(String)->()){
        guard let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") else{
            onFailure("Unable to reach the server.")
            return
        }
        AF.request(url)
            .validate()
            .response { (response) in
                guard  let d = response.data, let strISOLatin = String(data: d, encoding: .isoLatin1), let dataUTF8 = strISOLatin.data(using: .utf8), let dict = try? JSONSerialization.jsonObject(with: dataUTF8, options: []), let model = try? TableModel(from: dict)  else{
                    onFailure("Parsing error.")
                    return
                }
                self.updateData(dataMdl: model)
                onSuccess()
        }
    }
    
    func updateData(dataMdl:TableModel){
        self.data = dataMdl
        if let array = self.data?.rows{
            self.dataToShow = array
        }else{
            self.dataToShow = [TableModel.TableCellData?]()
        }
    }
    
    func getTitle()->String{
        return self.data?.title ?? "List"
    }
    
    func getNumberOfRows()->Int{
        return self.dataToShow.count
    }
    
    func getData(index:Int)->TableModel.TableCellData?{
        guard index < self.dataToShow.count else { return nil}
        return self.dataToShow[index]
    }
    
}
