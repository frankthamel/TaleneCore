//
//  TCAds.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 5/30/20.
//

import Foundation
import Malert
import WebKit

public class TCAds: UIView {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    var presenter: TCAdsPresenter?

    public override class func awakeFromNib() {
        super.awakeFromNib()
    }

    public class func instantiateFromNib() -> TCAds {
        return App.store.mainBundle.getAppBundle().loadNibNamed("TCAds", owner: self, options: nil)!.first as! TCAds
    }

    @IBAction func didTapOnShareButton(_ sender: Any) {
        presenter?.share()
    }

}

extension TCAds {

}



extension TCAds: TCAdsView {
    func loadUrl(_ request: URLRequest) {
        webView.load(request)
    }

    func setTitle(_ title: String?) {
        if let titleString = title {
            titleLabel.text = titleString
            titleLabel.isHidden = false
            self.layoutIfNeeded()
        } else {
            titleLabel.isHidden = true
        }
    }

    func setBody(_ body: String?) {
        if let bodyString = body {
            bodyLabel.text = bodyString
            bodyLabel.isHidden = false
            self.layoutIfNeeded()
        } else {
            bodyLabel.isHidden = true
        }
    }
}

extension AppAlerts {
    public static func createTCAdsAlert(model: AlertModel) -> Malert {
        let alertView = TCAds.instantiateFromNib()

        let presenter = TCAdsPresenter(with: alertView)
        let malert = Malert(customView: alertView)
        malert.separetorColor = .clear
        malert.backgroundColor = .clear
        malert.cornerRadius = 20

        model.malert = malert
        presenter.alertModel = model
        alertView.presenter = presenter
        presenter.setUp()

        return malert
    }
}
