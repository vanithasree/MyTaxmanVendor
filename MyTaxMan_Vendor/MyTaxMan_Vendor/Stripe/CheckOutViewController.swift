//
//  CheckOutViewController.swift
//  MyTaxMan_Vendor
//
//  Created by Vanithasree Rajeshkumar on 31/08/20.
//  Copyright © 2020 Vanithasree Rajeshkumar. All rights reserved.
//

import UIKit
import Stripe


class CheckOutViewController: BaseViewController {
    
    var choosenAmount : String = ""
    
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    lazy var payButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 5
        button.backgroundColor = ColorManager.textThickDarkGreenColor.color
        button.titleLabel?.font = UIFont(name:Font.FontName.PoppinsMedium.rawValue, size: Utility.dynamicSize(20.0))
        button.setTitle("Pay", for: .normal)
        button.addTarget(self, action: #selector(pay), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [cardTextField, payButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: view.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 20),
        ])
        /*Stripe.setDefaultPublishableKey("pk_test_51GtHk9H5W0t1liVhtEfjefWJI8BHQbozVn18suKGYxG81ha7famiOMHjgMC4B5xjiIUWkKlEphVtxhZXyVflD70O00ZbZIuyWB")*/
        // startCheckout()
    }
    func displayAlert(title: String, message: String, restartDemo: Bool = false) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if restartDemo {
                alert.addAction(UIAlertAction(title: "Restart demo", style: .cancel) { _ in
                    self.cardTextField.clear()
                    // self.startCheckout()
                })
            }
            else {
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc
    func pay() {
        // Collect card details on the client
        let cardParams = cardTextField.cardParams
        let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: nil)
        STPAPIClient.shared().createPaymentMethod(with: paymentMethodParams) { [weak self] paymentMethod, error in
            // Create PaymentMethod failed
            if let createError = error {
                self?.displayAlert(title: "Payment failed", message: createError.localizedDescription)
            }
            if let paymentMethodId = paymentMethod?.stripeId {
                print("Created PaymentMethod")
                self?.pay(withPaymentMethod: paymentMethodId)
            }
        }
    }
    
    // Create or confirm a PaymentIntent on the server
    func pay(withPaymentMethod paymentMethodId: String? = nil, withPaymentIntent paymentIntentId: String? = nil) {
        // Create a PaymentIntent on the server
        // let url = URL(string: BackendUrl + "pay")!
        let url = URL(string: "http://sunrisetechs.com/demo/MyTaxman/Stripe/stripe-php-master/create.php")!
        var json: [String: Any] = [:]
        /* {"currency":"aud","items":[{"amount":"25","id":"photo_subscription"}]}*/
        if let paymentMethodId = paymentMethodId {
            json = [
                "useStripeSdk": true,
                "paymentMethodId": paymentMethodId,
                "currency": "aud",
                "items": [
                    ["id": "photo_subscription", "amount": choosenAmount],
                ]
            ]
        }
        else if let paymentIntentId = paymentIntentId {
            json = [
                "paymentIntentId": paymentIntentId,
            ]
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, requestError) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    self?.displayAlert(title: "Payment failed", message: requestError?.localizedDescription ?? "")
                    return
            }
            let payError = json["error"] as? String
            let clientSecret = json["clientSecret"] as? String
            let requiresAction = json["requiresAction"] as? Bool
            
            // Payment failed
            if let payError = payError {
                self?.displayAlert(title: "Payment failed", message: payError)
            }
                // Payment succeeded, no additional action required
            else if clientSecret != nil && (requiresAction == nil || requiresAction == false) {
                self?.displayAlert(title: "Payment succeeded", message: clientSecret ?? "", restartDemo: false)
            }
                // Payment requires additional action
            else if clientSecret != nil && requiresAction == true && self != nil {
                let paymentHandler = STPPaymentHandler.shared()
                paymentHandler.handleNextAction(forPayment: clientSecret!, authenticationContext: self!, returnURL: nil) { status, paymentIntent, handleActionError in
                    switch (status) {
                    case .failed:
                        self?.displayAlert(title: "Payment failed", message: handleActionError?.localizedDescription ?? "")
                        break
                    case .canceled:
                        self?.displayAlert(title: "Payment canceled", message: handleActionError?.localizedDescription ?? "")
                        break
                    case .succeeded:
                        // After handling a required action on the client, the status of the PaymentIntent is
                        // requires_confirmation. You must send the PaymentIntent ID to your backend
                        // and confirm it to finalize the payment. This step enables your integration to
                        // synchronously fulfill the order on your backend and return the fulfillment result
                        // to your client.
                        if let paymentIntent = paymentIntent, paymentIntent.status == STPPaymentIntentStatus.requiresConfirmation {
                            print("Re-confirming PaymentIntent after handling action")
                            self?.pay(withPaymentIntent: paymentIntent.stripeId)
                        }
                        else {
                            self?.displayAlert(title: "Payment succeeded", message: paymentIntent?.description ?? "", restartDemo: true)
                        }
                        break
                    @unknown default:
                        fatalError()
                        break
                    }
                }
            }
        })
        task.resume()
    }
}

extension CheckOutViewController: STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
}

