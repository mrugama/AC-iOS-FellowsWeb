//
//  DetailView.swift
//  Fellows
//
//  Created by Alex Paul on 1/5/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var bioTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.init(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.0)
        tv.isEditable = false
        tv.isSelectable = false
        tv.layer.cornerRadius = 20
        tv.layer.masksToBounds = true
        tv.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        // here you get the actual frame size of the elements before getting
        // laid out on screen
        super.layoutSubviews()
        
        // make profile image a circle
        profileImage.layer.cornerRadius = profileImage.bounds.width/2.0
        profileImage.layer.masksToBounds = true
    }

    public func configureDetailView(fellow: Fellow, image: UIImage) {
        profileImage.image = image
        bioTextView.text = fellow.bio
        print("gihub: \(fellow.githubURL)")
    }
}

// MARK:- Setup Views
extension DetailView {
    private func setupViews() {
        backgroundColor = .white
        setupProfileImage()
        setupBioTextView()
    }
    
    private func setupProfileImage() {
        addSubview(profileImage)
        // TODO: layout using SnapKit
    }
    
    private func setupBioTextView() {
        addSubview(bioTextView)
        // TODO: layout using SnapKit
    }
    
    // TODO: add a Github link which segues to a WebView
}
