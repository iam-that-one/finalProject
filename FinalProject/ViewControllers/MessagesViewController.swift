//
//  ChatViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 31/12/2021.
//

import UIKit

class MessagesViewController: UIViewController {
    lazy var messagesTableView : UITableView = {
        $0.register(MessagsTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [messagesTableView].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            messagesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            messagesTableView.widthAnchor.constraint(equalToConstant: 380),
            messagesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messagesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20)
        ])
    }
}

extension MessagesViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "cell") as! MessagsTableViewCell
        cell.progilePic.image = UIImage(systemName: "person.circle.fill")
        return cell
    }
    
    
}
