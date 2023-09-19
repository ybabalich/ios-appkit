//
//  SendEmailService.swift
//  
//
//  Created by Yaroslav Babalich on 14.02.2021.
//

import MessageUI
import UIKit

open class SendEmailService: NSObject {

    // MARK: - Public methods

    public func presentUI(_ constructor: Constructor) {
        let recipientEmail = constructor.recipientEmail
        let body = constructor.formattedBody

        // Show default mail composer
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setMessageBody(body, isHTML: false)

            UIViewController.topController?.present(mail, animated: true, completion: nil)

            // Show third party email composer if default Mail app is not present
        } else if let emailUrl = createEmailUrl(receiver: recipientEmail, subject: "", body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }

    // MARK: - Private methods

    private func createEmailUrl(receiver: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        let gmailUrl = URL(string: "googlegmail://co?to=\(receiver)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(receiver)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(receiver)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(receiver)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(receiver)?subject=\(subjectEncoded)&body=\(bodyEncoded)")

        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }

        return defaultUrl
    }
}

extension SendEmailService: MFMailComposeViewControllerDelegate {

    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

public extension SendEmailService {
    struct Constructor {

        // MARK: - Public properties

        public let recipientEmail: String
        public let formattedBody: String

        public static var baseFormattedBody: String {
            var body = ""

            // info about build
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
               let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String { body.append("App version: \(version) (Build \(build))") }

            // info about device model name
            body.append("\n")
            body.append("Device model: " + UIDevice.modelName)

            // info about iOS version
            body.append("\n")
            body.append("System version: " + UIDevice.current.systemVersion)

            // info about user locale
            body.append("\n")
            body.append("Locale: " + Locale.current.identifier)

            return body
        }

        // MARK: - Initializers

        public init(recipientEmail: String, formattedBody: String) {
            self.recipientEmail = recipientEmail
            self.formattedBody = formattedBody
        }
    }
}
