//
//  OnboardingModel.swift
//  TaleneCore
//
//  Created by Frank Emmanuel on 7/28/20.
//

import Foundation

public struct OnboardingModel {
    public let informationImage: UIImage
    public let title: String
    public let description: String
    public let color: UIColor
    public let titleColor: UIColor
    public let descriptionColor: UIColor
    public let titleFont: UIFont
    public let descriptionFont: UIFont
    public let descriptionLabelPadding: CGFloat
    public let titleLabelPadding: CGFloat
}

public extension OnboardingModel {
    init?(informationImage: UIImage, title: String, description: String, color: UIColor = App.settings.theme.onboardingBackground, titleColor: UIColor = App.settings.theme.onboardingTitle, descriptionColor: UIColor = App.settings.theme.onboardingDescription, descriptionLabelPadding: CGFloat = 0, titleLabelPadding: CGFloat = 0 , titleFontName: String = "Helvetica-Bold", titleFontSize: CGFloat = 17, descriptionFontName: String = "Helvetica-Light", descriptionFontSize: CGFloat = 12) {
        if let titleFont = UIFont(name: titleFontName, size: titleFontSize ), let descriptionFont = UIFont(name: descriptionFontName, size: descriptionFontSize ) {
            self.init(informationImage: informationImage, title: title, description: description, color: color, titleColor: titleColor, descriptionColor: descriptionColor,  titleFont: titleFont, descriptionFont: descriptionFont, descriptionLabelPadding: descriptionLabelPadding, titleLabelPadding: titleLabelPadding)
        } else {
            return nil
        }
    }
}


