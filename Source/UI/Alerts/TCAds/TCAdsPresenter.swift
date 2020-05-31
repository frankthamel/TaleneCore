//
//  TCAdsPresenter.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/30/20.
//

import UIKit

protocol TCAdsView: class {
    func loadUrl(_ request: URLRequest)
}

class TCAdsPresenter: AlertPresenterBase {
    weak var view: TCAdsView?
    var alertModel: AlertModel?
    var adsShareModel: AdsShareModel?

    init(with view: TCAdsView) {
        self.view = view
    }

    func setUp() {
        adsShareModel = alertModel?.params?[TCConstants.model] as? AdsShareModel

        if let request = getLoadUrlrequest() {
            view?.loadUrl(request)
        }
    }

    func share() {
        guard let model = adsShareModel else {
            // error
            return
        }
        
        App.managers.logger.error(message: "Share message on Facebook. \(model.message)")
    }

    private func getLoadUrlrequest() -> URLRequest? {
        let openUrl = URL(string: adsShareModel?.openUrl ?? "")

        guard let url = openUrl else {
            return nil
        }

        let request = URLRequest(url: url)
        return request
    }

}
