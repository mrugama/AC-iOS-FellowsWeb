//
//  DetailViewController.swift
//  Fellows
//
//  Created by Alex Paul on 1/5/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    private var fellow: Fellow!
    private var sfSafariVC: SFSafariViewController!
    
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
        detailView.safariLinkButton.addTarget(self, action: #selector(launchSafari), for: UIControlEvents.touchUpInside)
        detailView.webViewLinkButton.addTarget(self, action: #selector(showWebView), for: .touchUpInside)
        detailView.githubLinkButton.addTarget(self, action: #selector(showSFSafariVC), for: .touchUpInside)
        configureNavBar()
    }
    // Presenting Web Content (Method 1) - via Safari
    // downside: user is taken away from your app, may no return :-(
    @objc private func launchSafari() {
        UIApplication.shared.open(URL(string: "https://github.com/mrugama")!, options: [:]) { (done) in
            print("Safari was launched")
        }
    }
    
    
    // Presenting web content (method 2) - via WKWebView
    // Advantages: developer is able to customize UI, user is still in your app
    // Disadvantages: you don't access to tha apple's keychain, so the user's credentials is not available
    @objc private func showWebView() {
        let urlRequest = URLRequest(url: URL(string: "https://c4q.nyc")!)
        let webVC = WebViewController(urlRequest: urlRequest)
        navigationController?.pushViewController(webVC, animated: true)
        
    }
    
    // Presenting Web Content (Method 3) - via SFSafariViewController
    // Advantage:   * all the benefits of Safari, e.g Apple Keychain access
    //              * users stay within your app
    //              * third party authentication via (Oauth) e.g logging with Facebook
    // Disadvantage: n/a
    @objc private func showSFSafariVC() {
        sfSafariVC = SFSafariViewController(url: fellow.githubURL)
        sfSafariVC.delegate = self
        navigationController?.pushViewController(sfSafariVC, animated: true)
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

extension DetailViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        navigationController?.popViewController(animated: true)
    }
}
