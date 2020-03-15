//
//  TableViewCell.swift
//  TableViewTest
//
//  Created by cnu on 09/03/20.
//  Copyright © 2020 Guest User. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private let productNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let productDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let productImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addViews()
    }
    
    func addViews(){
        self.contentView.addSubview(productImage)
        self.contentView.addSubview(productNameLabel)
        self.contentView.addSubview(productDescriptionLabel)
        
        productImage.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 50, height: 50, enableInsets: false)
        productImage.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        productNameLabel.anchor(top:  self.contentView.topAnchor, left: productImage.rightAnchor, bottom: nil, right:  self.contentView.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        productDescriptionLabel.anchor(top: productNameLabel.bottomAnchor, left: productImage.rightAnchor, bottom: self.contentView.bottomAnchor, right: self.contentView.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 20, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
    func setupViews(data:TableModel.TableCellData?) {
      
        self.productImage.sd_setImage(with: URL(string:(data?.imageHref) ?? ""), placeholderImage: UIImage(named: "placeholder"), options: .continueInBackground, context: nil)
        self.productNameLabel.text = data?.title ?? "N/A"
        self.productDescriptionLabel.text = data?.description ?? "N/A"
        self.layoutIfNeeded()
    }
}
