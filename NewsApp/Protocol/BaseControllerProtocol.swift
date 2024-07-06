//
//  BaseControllerProtocol.swift
//  NewsApp
//
//  Created by Emrah Zorlu on 5.07.2024.
//

import Foundation

protocol BaseControllerProtocol: AnyObject { }

protocol BaseViewModelProtocol: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func viewWillAppear()
    func viewDidDisappear()
    func viewWillDisappear()
    func didEnterBackground()
}

extension BaseViewModelProtocol {
    func viewDidLoad() { }
    func viewDidAppear() { }
    func viewWillAppear() { }
    func viewDidDisappear() { }
    func viewWillDisappear() { }
    func didEnterBackground() { }
}
