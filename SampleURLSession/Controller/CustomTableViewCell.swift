//
//  CustomTableViewCell.swift
//  SampleURLSession
//
//  Created by Yogesh Wagh on 18/06/18.
//  Copyright © 2018 yogesh. All rights reserved.
//

import UIKit

class CustomTableViewCell : UITableViewCell
{
    var titleLabel:UILabel!
    var descriptionLabel:UILabel!
    var customimageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        super.contentView.backgroundColor = UIColor.white
        
        let marginGuide = contentView.layoutMarginsGuide
        titleLabel = UILabel(frame: self.bounds)
        descriptionLabel = UILabel(frame: self.bounds)
        customimageView = UIImageView(frame: self.bounds)
        
        contentView.addSubview(customimageView)
        
        customimageView.translatesAutoresizingMaskIntoConstraints = false
        customimageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        customimageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        customimageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        customimageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
      
        
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: customimageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0
        
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Avenir-Book", size: 12)
        descriptionLabel.textColor = UIColor.lightGray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        let result = super.systemLayoutSizeFitting(targetSize)
        return result
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        let result = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        
        return result
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum HeightConstraintLocation {
        case cell, contentView, contentViewSubview
    }
}

extension CustomTableViewCell : TextableLabel {
    func configureWithItem(data:Fact?) -> Void {
        self.titleLabel.text = data?.title
        self.descriptionLabel.text = data?.description
        if(data!.imageHref.count > 0)
        {
            customimageView.image = UIImage(named: "noimage")
            downloadImage(url: URL(string: (data?.imageHref)!)!)
        }
        else
        {
            //customimageView.image = UIImage(named: "noimage")
            customimageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            customimageView.widthAnchor.constraint(equalToConstant: 0).isActive = true
        }
    }
    
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.customimageView.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
}
