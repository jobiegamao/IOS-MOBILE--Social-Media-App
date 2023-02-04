//
//  ProfileViewController.swift
//  twitterclone_swift
//
//  Created by may on 2/4/23.
//

import UIKit

class ProfileViewController: UIViewController {
	
//	statusbar to appear on scroll only
//	updated by viewdidscroll
	private var isStatusBarHidden = true
	private let statusBar: UIView = {
		let view = UIView()
		view.backgroundColor = .systemBackground
		view.layer.opacity = 0
		view.layer.zPosition = 999
		return view
	}()

	private let profileTableView: UITableView = {
		let table = UITableView()
		table.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
		table.translatesAutoresizingMaskIntoConstraints = false
		table.rowHeight = UITableView.automaticDimension
		return table
	}()
	
	lazy private var headerView: UIView = {
		let view = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height * 2/5))
		return view
	}()
	
	private func configureConstraints(){
		NSLayoutConstraint.activate([
			 
		])
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = .systemBackground
		
		view.addSubview(statusBar)
		view.addSubview(profileTableView)
		profileTableView.delegate = self
		profileTableView.dataSource = self
		
		profileTableView.tableHeaderView = headerView
		
		
		
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		profileTableView.frame = view.bounds
		statusBar.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height > 800 ? 50 : 30)
		print(statusBar.frame.height)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
		profileTableView.contentInsetAdjustmentBehavior = .never

		 
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 10
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {return UITableViewCell() }
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let yPositionScroll = scrollView.contentOffset.y

		if yPositionScroll > (view.bounds.height * 1/15) && isStatusBarHidden {
			isStatusBarHidden = false
			UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
				[weak self] in
				self?.statusBar.layer.opacity = 1
			}
		} else if yPositionScroll < 0 && !isStatusBarHidden {
			isStatusBarHidden = true
			UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {
				[weak self] in
				self?.statusBar.layer.opacity = 0
			}
		}
	}
}



