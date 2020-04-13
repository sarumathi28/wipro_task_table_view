//
//  Extensions.swift
//  TableViewTest
//
//  Created by Guest User on 09/03/2020.
//  Copyright © 2020 Guest User. All rights reserved.
//

import Foundation

import SDWebImage

extension UIViewController{
    func showAlert(title: String? = nil, message : String, buttonTitle: String? = nil, completionHandler:(() -> ())? = nil)
    {
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: buttonTitle ?? "OK", style: .default) {
            (action: UIAlertAction) in
            completionHandler?()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

extension Decodable{
    init?(from: [String:Any]) {
        if let data = try? JSONSerialization.data(withJSONObject: from, options: .prettyPrinted){
            if let s = try? JSONDecoder().decode(Self.self, from: data){
                self = s
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:sszzz"
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

extension UITableView{
    var pullToRefreshControl : UIRefreshControl? {
        get{
            if self.refreshControl == nil{
                self.refreshControl = UIRefreshControl()
            }
            return self.refreshControl
        }
    }

    
    func programaticallyBeginRefreshing() {
        if let refreshControl = self.pullToRefreshControl{
            refreshControl.beginRefreshing()
            let offsetPoint = CGPoint.init(x: 0, y: -refreshControl.frame.size.height)
            self.setContentOffset(offsetPoint, animated: true)
        }
    }

}

extension UIView {
 
 func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
 var topInset = CGFloat(0)
 var bottomInset = CGFloat(0)
 
// if #available(iOS 11, *), enableInsets {
 let insets = self.safeAreaInsets
 topInset = insets.top
 bottomInset = insets.bottom
 
//    print("Top: \(topInset)”)
//        print("bottom: \(bottomInset)”)
// }
 
 translatesAutoresizingMaskIntoConstraints = false
 
 if let top = top {
 self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
 }
 if let left = left {
 self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
 }
 if let right = right {
 rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
 }
 if let bottom = bottom {
 bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
 }
 if height != 0 {
 heightAnchor.constraint(equalToConstant: height).isActive = true
 }
 if width != 0 {
 widthAnchor.constraint(equalToConstant: width).isActive = true
 }
 
 }
 
}
