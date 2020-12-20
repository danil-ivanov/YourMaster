//
//  ServicesPresenter.swift
//  YourMaster
//
//  Created by Maxim Egorov on 04.12.2020.
//  Copyright © 2020 Maxim Egorov. All rights reserved.
//

import UIKit

protocol ServicesPresenterOutput: AnyObject {
    func didRequestServices(shop: Shop)
    func servicesDidClose()
}

final class ServicesPresenter {
    weak var view: ServicesViewInput?
    private let output: ServicesPresenterOutput
    private let shop: Shop
    
    private var initialSectionModels: [TableSectionIdentifiable]
    private var servicesDict: [String : [Service]]
    
    private var filteredSectionModels: [TableSectionIdentifiable] {
        didSet {
            view?.presentServices()
        }
    }

    init(output: ServicesPresenterOutput, shop: Shop) {
        self.output = output
        self.shop = shop
        self.initialSectionModels = []
        self.filteredSectionModels = []
        self.servicesDict = [:]
    }
    
    private func createSectionModels(from dict: [String : [Service]]) -> [TableSectionIdentifiable] {
        let sectionModels: [TableSectionIdentifiable] = dict.compactMap({ category, services  in
            if services.isEmpty {
                return nil
            }
            let collectionModels = services.map { ServiceCollectionCellModel(name: $0.name, price: $0.price) }
            let tableCell = CollectionViewTableCellModel(collectionModels: collectionModels,
                                                       height: 120,
                                                       cellsForRegistration: [ServiceCollectionCell.self])
            let section = StandardTextSectionModel(title: category, height: 40)
            section.cellModels = [tableCell]
            return section
        })
        return sectionModels
    }
}

extension ServicesPresenter: ServicesViewOutput {

    func didRequestServices() {
        view?.startLoading()
        output.didRequestServices(shop: shop)
    }
    
    var numberOfSections: Int {
        return filteredSectionModels.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return filteredSectionModels[section].cellModels.count
    }
    
    func configure() {
        view?.prepareInterface()
    }

    func configure(_ cell: TableCell, at row: Int, in section: Int) {
        cell.model = filteredSectionModels[section].cellModels[row]
    }
    
    func configure(_ view: TableSection, in section: Int) {
        view.model = filteredSectionModels[section]
    }
    
    func viewDidClose() {
        print("VIEW DID CLOSE")
        output.servicesDidClose()
    }
    
    func search(_ text: String) { } 
}

extension ServicesPresenter: ServicesPresenterInput {
    func updateServices(servicesDict: [String : [Service]]) {
        view?.finishLoading()
        self.servicesDict = servicesDict
        filteredSectionModels = createSectionModels(from: servicesDict)
        initialSectionModels = filteredSectionModels
    }
}
