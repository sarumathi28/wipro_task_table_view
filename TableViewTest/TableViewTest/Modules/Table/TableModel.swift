//
//  Model.swift
//  TableViewTest
//
//  Created by Guest User on 09/03/2020.
//  Copyright © 2020 Guest User. All rights reserved.
//

import Foundation

struct TableModel:Codable, Equatable {
    struct TableCellData:Codable, Equatable {
        let title:String?
        let description:String?
        let imageHref:String?
    }
    let title:String?
    let rows:[TableCellData?]?
}
