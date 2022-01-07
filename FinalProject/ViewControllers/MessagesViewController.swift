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
    
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "محادثاتي"
        $0.backgroundColor = UIColor.systemGray6
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 40
        return $0
    }(PaddingLabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [messagesTableView,newLable].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 120),
            
            messagesTableView.topAnchor.constraint(equalTo: newLable.bottomAnchor ,constant: 10),
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
