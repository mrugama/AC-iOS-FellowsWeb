//
//  DetailViewController.swift
//  Fellows
//
//  Created by Alex Paul on 1/5/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    private var fellow: Fellow!
    
    init(fellow: Fellow, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.fellow = fellow
        detailView.configureDetailView(fellow: fellow, image: image)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(detailView)
        configureNavBar()
    }
    
    private func configureNavBar() {
        navigationItem.title = "\(fellow.name)"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // scroll to top of text view
        let range = NSRangeFromString(detailView.bioTextView.text)
        detailView.bioTextView.scrollRangeToVisible(range)
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }

}
