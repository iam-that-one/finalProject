//
//  ChatViewController.swift
//  FinalProject
//
//  Created by Abdullah Alnutayfi on 01/01/2022.
//

import UIKit

class ChatViewController: UIViewController {

    lazy var chatTableView : UITableView = {
        $0.register(ChatTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 600
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.dataSource = self
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        return $0
    }(UITableView())
    
    lazy var messageTf : UITextField = {
        $0.placeholder = ""
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 25
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    
    lazy var newLable : PaddingLabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "أحمد"
        $0.backgroundColor = UIColor.systemGray6
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.textColor = .black
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.paddingTop = 40
        return $0
    }(PaddingLabel())
    
    lazy var sendButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(sentBtnClick), for: .touchDown)
        $0.tintColor = .darkGray
        $0.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return $0
    }(UIButton(type: .system))
    
    lazy var backToOfferViewBtn : UIButton = {
        $0.setBackgroundImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(backToDetailsViewBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setBackgroundImage(imageName: "chatBackG")
        [messageTf,sendButton,newLable,chatTableView,backToOfferViewBtn].forEach{view.addSubview($0)}
        
        NSLayoutConstraint.activate([
            
            newLable.topAnchor.constraint(equalTo: view.topAnchor),
            newLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newLable.heightAnchor.constraint(equalToConstant: 100),
            backToOfferViewBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            backToOfferViewBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            
            chatTableView.topAnchor.constraint(equalTo: newLable.bottomAnchor,constant: 30),
            chatTableView.widthAnchor.constraint(equalToConstant: 380),
            chatTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: messageTf.topAnchor,constant: -20),
                                                    
            messageTf.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 5),
            messageTf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageTf.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-70),
            messageTf.heightAnchor.constraint(equalToConstant: 40),
            
            sendButton.leadingAnchor.constraint(equalTo: messageTf.trailingAnchor,constant: 5),
            sendButton.centerYAnchor.constraint(equalTo: messageTf.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    @objc func sentBtnClick(){
        
    }
    @objc func backToDetailsViewBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
    func setBackgroundImage(imageName: String){
          let background = UIImage(named: imageName)
          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
          imageView.contentMode =  .scaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
          view.addSubview(imageView)
          self.view.sendSubviewToBack(imageView)
      }
}

extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Message.example.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! ChatTableViewCell
        cell.username.text = Message.example[indexPath.row].name
        cell.content.text = Message.example[indexPath.row].content
        cell.date.text = Message.example[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
