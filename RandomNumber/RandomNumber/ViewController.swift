//
//  ViewController.swift
//  RandomNumber
//
//  Created by Flavio Dobler on 29/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    var randomNumber : Int = 0
    public var lives : Int = 3
    
    
    let sucessAlert = UIAlertController(title: "NICE!!", message: "You got it right!", preferredStyle: .alert)
    let failAlert = UIAlertController(title: "You lost!",message: "Try it again!" , preferredStyle: .alert)
    let noLivesAlert = UIAlertController(title: "GAME OVER!!", message: "=(", preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "OK", style: .default)
    let continu = UIAlertAction(title: "Try Again", style: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan
        layout()
        setupAlerts()
    }
    
    func setupAlerts() {
            sucessAlert.addAction(ok)
            failAlert.addAction(ok)
            noLivesAlert.addAction(continu)
        }
    
    
    lazy var questionImage : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "question")
        imageView.isHidden = false
        return imageView
    }()
    
    
    lazy var numberTextField : UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Number here"
        field.keyboardType = .numberPad
        field.borderStyle = UITextField.BorderStyle.roundedRect
        field.layer.borderWidth = 1
        field.delegate = self
        return field
    }()
    
    lazy var randomButtom : UIButton = {
        let buttom = UIButton()
        buttom.translatesAutoresizingMaskIntoConstraints = false
        buttom.setTitle("Generate Number!", for: .normal)
        buttom.layer.cornerRadius = 12
        buttom.backgroundColor = .systemBackground
        buttom.setTitleColor(.black, for: .normal)
        buttom.addTarget(self, action: #selector(self.generateButtom), for: .touchUpInside)
        return buttom
    }()
    
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Guess the number from 0 to 9!"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    func layout() {
        view.addSubview(numberLabel)
        view.addSubview(numberTextField)
        view.addSubview(randomButtom)
        view.addSubview(questionImage)
        
        NSLayoutConstraint.activate([
            
            numberLabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 120),
            numberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            randomButtom.topAnchor.constraint(equalTo: numberLabel.bottomAnchor , constant: 12),
            randomButtom.centerXAnchor.constraint(equalTo: numberLabel.centerXAnchor),
            randomButtom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            
            numberTextField.topAnchor.constraint(equalTo: randomButtom.bottomAnchor, constant: 20),
            numberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    
           
            questionImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionImage.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 100),
            questionImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            questionImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            questionImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
            
            
            
        ])
    }
    
    @objc  func generateButtom(sender: UIButton) {
        var randomInt = Int.random(in: 0..<9)
        randomNumber = randomInt
        print(randomInt)
        let userInput = numberTextField.text
        self.animateButtom(sender)
    }
   
   
    
    private func animateButtom (_ animate: UIView) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            animate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) {  (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2,options: .curveEaseIn ,animations: { animate.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            },completion: nil)
        }

    }
}


extension ViewController : UITextFieldDelegate {
    //Limitar Numero de Caracteres no TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        let updatetext =  currentText.replacingCharacters(in: stringRange, with: string)
        return updatetext.count <= 1
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let userInput = textField.text, let guess = Int(userInput) else {
                    return false
                }
                if guess == randomNumber {
                    present(sucessAlert, animated: true, completion: nil)
                    return true
                } else {
                    lives -= 1
                    if lives == 0 {
                        present(noLivesAlert, animated: true, completion: nil)
                        lives = 3
                    } else {
                        failAlert.message = "You have \(lives) tries left."
                        present(failAlert, animated: true, completion: nil)
                    }
                    return false
                }
            }
}
