//
//  DetailViewController.swift
//  Navigation
//
//  Created by Ольга Бойко on 15.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    //загружаем главный экран
    override func loadView() {
        super.loadView()
        print(#function)
    }
    
    //срабатывает после загрузки главного экрана
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .blue
//        print(#function)
//    }
    
    //срабатывает каждый раз при попадании на экран
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    //после того, как контроллер появляется на экране
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    //перед уничтожением экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
    
    //после уничтожения экрана
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
    }
    
    deinit {
        print("deinit\(self)")
    }
}
