//
//  TCAdsPresenter.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/30/20.
//

import UIKit

protocol TCAdsView: class {
    func loadUrl(_ request: URLRequest)
    func setTitle(_ title: String?)
    func setBody(_ body: String?)
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

        view?.setTitle(adsShareModel?.title)
        view?.setBody(adsShareModel?.message)
    }

    func share() {
        guard let model = adsShareModel, let vc = App.context.activeViewController else {
            App.managers.loader.showFail()
            return
        }

        alertModel?.malert?.dismiss(animated: true, completion: {
            if model.useActivityViewController {
                App.services.socialShareService.activityViewController.share(model, inController: vc, withCompletion: nil)
            } else {
                App.services.socialShareService.facebookService.share(urlString: model.shareUrl ?? "", withComment: model.message, hashTag: model.hashTags.first ?? "", inViewController: vc, delegate: nil)
            }
        })

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
