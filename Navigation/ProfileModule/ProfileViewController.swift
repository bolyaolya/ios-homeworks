//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 30.08.2022.
//
import UIKit
import StorageService

class ProfileViewController : UIViewController {
    
    //MARK: свойства
    
    let userService : UserService
    let name : String
    
    init(userService: UserService, name: String) {
        self.userService = userService
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var profileHeader: ProfileHeaderView = {
        let profileHeader = ProfileHeaderView()
        return profileHeader
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "ProfileCellID")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCellID")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCellID")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    ///копия аватара
    private lazy var copyAvatar : UIImageView = {
        let copyAvatar = UIImageView()
        copyAvatar.image = UIImage(named: "hypno")
        copyAvatar.clipsToBounds = true
        copyAvatar.layer.cornerRadius = 25
        copyAvatar.isUserInteractionEnabled = true
//        copyAvatar.isHidden = true
        copyAvatar.translatesAutoresizingMaskIntoConstraints = false
        return copyAvatar
    }()
    
    private lazy var sizeOfAvatar : CGPoint = CGPoint(x: copyAvatar.frame.size.width, y: copyAvatar.frame.size.height)
    private lazy var spaceToAvatar : CGPoint = CGPoint(x: copyAvatar.frame.origin.x, y: copyAvatar.frame.origin.y)
    
    private lazy var blurView : UIVisualEffectView = {
        let blurView = UIVisualEffectView()
        blurView.isHidden = true
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    private lazy var closeButton : UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.layer.cornerRadius = 20
        closeButton.isHidden = true
        closeButton.clipsToBounds = true
        closeButton.isUserInteractionEnabled = true
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        return closeButton
    }()
    
    
    
    //MARK: жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        //добавлен таймер от усталости
//        Timer.scheduledTimer(withTimeInterval: 5.0,
//                             repeats: false) { timer in
//
//            let alert = UIAlertController(title: "Вы здесь уже 5 секунд",
//                                          message: "Пора бы отдохнуть...",
//                                          preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
//
//            print("Пора бы отдохнуть...")
//            self.present(alert, animated: true)
//            timer.invalidate()
//        }
    }
    
    //MARK: методы
    
    private func layout() {
        #if DEBUG
        view.backgroundColor = .red
        #else
        view.backgroundColor = .white
        #endif
        view.addSubview(tableView)
        view.addSubview(blurView)
        view.addSubview(copyAvatar)
        view.addSubview(closeButton)
        setupNavBar()
        setupConstraints()
        avatarTapGesture()
        closeButtonTapGesture()
        
        let blurViewEffect = UIBlurEffect(style: .systemChromeMaterialLight)
        blurView.effect = blurViewEffect
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            copyAvatar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            copyAvatar.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 16),
            copyAvatar.widthAnchor.constraint(equalToConstant: 100),
            copyAvatar.heightAnchor.constraint(equalToConstant: 100),
            
            closeButton.heightAnchor.constraint(equalToConstant: 60),
            closeButton.widthAnchor.constraint(equalToConstant: 60),
            closeButton.topAnchor.constraint(equalTo: blurView.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    ///тап по аватару
    private func avatarTapGesture() {
        let avatarTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAvatar))
        avatarTapGesture.numberOfTapsRequired = 1
        avatarTapGesture.numberOfTouchesRequired = 1
        copyAvatar.isUserInteractionEnabled = true
        copyAvatar.addGestureRecognizer(avatarTapGesture)
    }
    
    ///тап по кнопке закрытия
    private func closeButtonTapGesture() {
        let closeButtonTapGesture = UITapGestureRecognizer(target: self, action: #selector(TapGestureClose))
        closeButton.addGestureRecognizer(closeButtonTapGesture)
        }
    
    @objc private func tapGestureAvatar(_ gestureRecognizer: UITapGestureRecognizer) {
        
        ///расчет размера, на сколько увеличивать аватарку
        let scaleRatio = self.blurView.frame.width / self.copyAvatar.frame.width
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
            ///отображаем полупрозрачную вью
            self.copyAvatar.isHidden = false
            self.blurView.isHidden = false
            
            ///размещаем аватар по центру и увеличиваем
            self.copyAvatar.center = self.blurView.center
            self.copyAvatar.transform = CGAffineTransform(scaleX: scaleRatio, y: scaleRatio)
            self.copyAvatar.isUserInteractionEnabled = false
            
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
                self.closeButton.isHidden = false
            }
        }
    }
    
    ///тап по кнопке закрытия
    
    @objc private func TapGestureClose(_ gestureRecognizer: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.closeButton.isHidden = true
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn) {
                    self.copyAvatar.frame = CGRect(x: self.spaceToAvatar.x, y: self.spaceToAvatar.y, width: self.sizeOfAvatar.x, height: self.sizeOfAvatar.y)
                    self.copyAvatar.transform = .identity
                    self.blurView.isHidden = true
                    self.copyAvatar.isHidden = true
            }
        }
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCellID", for: indexPath) as! PhotosTableViewCell

            return cell
        } else {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellID", for: indexPath) as! PostTableViewCell

            let dataSource = post[indexPath.row - 1]
            cell.setup(dataSource)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = profileHeader
            let user = userService.checkLogin(login: name)
            header.fullNameLabel.text = user?.fullName
            header.avatarImageView.image = user?.avatar
            header.statusLabel.text = user?.status
            
            return header
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        }
        return 0
        }
    
    ///переход на другое окно тапом по ряду
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigationController?.pushViewController(PhotosViewController(), animated: true)
            }
        else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
