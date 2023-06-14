//
//  ViewController.swift
//  QuizApp
//
//  Created by Zaid Sheikh on 13/06/2023.
//

import UIKit


class ViewController: UIViewController {
    
    let gray = UIColor(hex: "DEDDDD")
    let onePixelPoint = 1.0 / UIScreen.main.scale
    
    var animCont: UIView!
    var animContHalf: UIView!
    
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let answerButtons: [UIButton] = {
        var buttons = [UIButton]()
        for _ in 0..<3 {
            let button = UIButton()
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttons.append(button)
        }
        return buttons
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let restartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.isHidden = true
        return button
    }()
    
    var questions: [Question] = []
    var currentQuestionIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
//        view.sendSubviewToBack(backgroundImageView)
        startAnims()
        setupViews()
        // Initialize the quiz questions
        questions = [
            Question(text: "What year was the United Nations established?", options: ["1945", "1950", "1940"], correctAnswer: 0),
            Question(text: "What country has won the most World Cups?", options: ["France", "Brazil", "Germany"], correctAnswer: 1),
            Question(text: "How many bones do we have in an ear?", options: ["1", "3", "2"], correctAnswer: 1),
            Question(text: "The first rocket launched by Pakistan was:", options: ["Rahbar", "Nasr", "Shaheen"], correctAnswer: 0),
            Question(text: "Which animal can create the loudest sound among any living creature?", options: ["Humpback whales", "Lion", "Elephant"], correctAnswer: 0),
            Question(text: "What is the largest country in the world?", options: ["Russia", "Canada", "China"], correctAnswer: 0),
            Question(text: "How many elements are in the periodic table?", options: ["118", "119", "117"], correctAnswer: 0),
            Question(text: "Ishkoman Valley is situated in which district of Gilgit Baltistan?", options: ["Ghizer", "Astore", "Hunza"], correctAnswer: 0),
            Question(text: "International Day against Women violence is celebrated each year on?", options: ["26 November", "23 November", "25 November"], correctAnswer: 2)
        ]
        
        // Load the first question
        loadQuestion()
    }
    

 
    func setupViews() {
        view.addSubview(questionLabel)
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        for (index, button) in answerButtons.enumerated() {
            view.addSubview(button)
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: CGFloat(index * 75 + 50)),
                button.widthAnchor.constraint(equalToConstant: 250),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            button.addTarget(self, action: #selector(answerButtonTapped(_:)), for: .touchUpInside)
        }
        
        view.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreLabel.topAnchor.constraint(equalTo: answerButtons.last!.bottomAnchor, constant: 40)
        ])
        
        view.addSubview(restartButton)
        NSLayoutConstraint.activate([
            restartButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartButton.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 20),
            restartButton.widthAnchor.constraint(equalToConstant: 100),
            restartButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
    }
    
    func loadQuestion() {
        let question = questions[currentQuestionIndex]
        //        questionLabel.text = question.text
        
        UIView.transition(with: questionLabel, duration: 1, options: .transitionCrossDissolve, animations: {
            self.questionLabel.text = question.text
        }, completion: nil)
        
        
        for (index, button) in answerButtons.enumerated() {
            //            button.setTitle(question.options[index], for: .normal)
            
            UIView.transition(with: button, duration: 1, options: .transitionCrossDissolve, animations: {
                button.setTitle(question.options[index], for: .normal)
            }, completion: nil)
        }
    }
    
    func checkAnswer(selectedAnswerIndex: Int) {
        let question = questions[currentQuestionIndex]
        if selectedAnswerIndex == question.correctAnswer {
            score += 1
        }
    }
    
    func showNextQuestion() {
        currentQuestionIndex += 1
        
        if currentQuestionIndex < questions.count {
            loadQuestion()
        } else {
            self.showFinalScore()
        }
    }
    
    func showFinalScore() {
        // Display the final score to the user
        //        questionLabel.text = "Quiz completed!"
        //        scoreLabel.text = "Your score: \(score)/\(questions.count)"
        
        UIView.transition(with: questionLabel, duration: 1, options: .transitionCrossDissolve, animations: {
            self.questionLabel.text = "Quiz completed!"
        }, completion: nil)
        
        UIView.transition(with: scoreLabel, duration: 1, options: .transitionCrossDissolve, animations: {
            self.scoreLabel.text = "Your score: \(self.score)/\(self.questions.count)"
        }, completion: nil)
        
        // Disable answer buttons
        for button in answerButtons {
            //            button.isEnabled = false
            UIView.transition(with: button, duration: 1.5, options: .transitionCrossDissolve, animations: {
                button.isEnabled = false
                button.alpha = 0.3
            }, completion: nil)
            button.isHidden = true
        }
        
        // Show the restart button
        
        UIView.transition(with: restartButton, duration: 1, options: .transitionCrossDissolve, animations: {
            self.restartButton.isHidden = false
        }, completion: nil)
        
        UIView.transition(with: scoreLabel, duration: 1, options: .transitionCrossDissolve, animations: {
            self.scoreLabel.isHidden = false
        }, completion: nil)
        
        //        restartButton.isHidden = false
        //        scoreLabel.isHidden = false
    }
    
    func restartQuiz() {
        // Reset the quiz state
        currentQuestionIndex = 0
        score = 0
        
        // Enable answer buttons
        for button in answerButtons {
            UIView.transition(with: button, duration: 1.5, options: .transitionCrossDissolve, animations: {
                button.isEnabled = true
                button.alpha = 1
                button.isHidden = false
            }, completion: nil)
        }
        
        // Hide the restart button
        restartButton.isHidden = true
        scoreLabel.isHidden = true
        
        // Load the first question
        loadQuestion()
    }
    
    @objc func answerButtonTapped(_ sender: UIButton) {
        guard let selectedAnswerIndex = answerButtons.firstIndex(of: sender) else { return }
        checkAnswer(selectedAnswerIndex: selectedAnswerIndex)
        showNextQuestion()
    }
    
    @objc func restartButtonTapped() {
        restartQuiz()
    }
    
    
    func startAnims() {
        animContHalf = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 2))
        animContHalf.clipsToBounds = true
        view.addSubview(animContHalf)
        animCont = UIView(frame: view.bounds)
        view.addSubview(animCont)
        
        view.sendSubviewToBack(animCont)
        view.sendSubviewToBack(animContHalf)
        
        let rect = CGRect(x: 0, y: 0, width: animCont.frame.width, height: animCont.frame.width)
        Shapes.createDotedShape(view: animContHalf, rect: rect, duration: 60 * 3, dash: [1, 5], scale: 1.1, color: gray)
        Shapes.createDotedShape(view: animContHalf, rect: rect, duration: 60 * 1, dash: [1, 10], scale: 1.2, color: UIColor.darkGray)
        Shapes.createDotedShape(view: animContHalf, rect: rect, duration: 60 * 1, dash: [60, 60], scale: 1.55, lineWidth: onePixelPoint, color: UIColor.darkGray)
        let bounds = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        for _ in 1...4 {
            Shapes.createRandTriangleAndAnim(view: animCont, bounds: bounds)
            Shapes.createRandCircleAndAnim(view: animCont, bounds: bounds)
            Shapes.createRandRectAndAnim(view: animCont, bounds: bounds)
        }
    }
}

struct Question {
    let text: String
    let options: [String]
    let correctAnswer: Int
}
