//
//  ViewController.swift
//  TableView_CustomCell
//
//  Created by Roman Shestopal on 29.11.2021.
//

import UIKit

protocol ProtocolQuestion {
    func change(_: ExampleTableViewCell, index: Int)
    func showAC(_: ExampleTableViewCell, index: Int)
    func didTapBtn(with tag: Int)
}

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var questions: [String] = ["How are You?","What is your name?","Where do You work?","How old are You?"]
    var question1 = Question(question: "What is your name?", answer: ["Ivan", "Roman", "Oleg", "Andriy"], trueAnswer: [1])
    var question2 = Question(question: "What do You do?", answer: ["Swimming","Working","Playing","Reading"],trueAnswer: [1,3])
    var arrQuestion: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "ExampleTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "ExampleTableViewCell")
        myTableView.delegate = self
        myTableView.dataSource = self
        
        arrQuestion.append(question1)
        arrQuestion.append(question2)
    }
    
//    func addQuestion(question: Question){
//        question.question
//    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource, ProtocolQuestion{
    
    func didTapBtn(with tag: Int) {
        print("\(tag)")
    }
    
    func showAC(_: ExampleTableViewCell, index: Int){
        let alert = UIAlertController(title: "Warning", message: "Do You want to delete question?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "No", style: .default, handler: nil)
        let delete = UIAlertAction(title: "Delete", style: .default, handler: { add in
            self.arrQuestion.remove(at: index)
            self.myTableView.reloadData()
        })
        
        alert.addAction(cancel)
        alert.addAction(delete)
        
        present(alert, animated: true, completion: nil)
    }
    
    func change(_: ExampleTableViewCell, index: Int) {
        let alert = UIAlertController(title: "Change", message: "You can change question and answers", preferredStyle: .alert)
        var changedQuestion: String = ""
        var changeAnswer1 = ""
        var changeAnswer2 = ""
        var changeAnswer3 = ""
        var changeAnswer4 = ""
        
        let questionTF: Void = alert.addTextField(configurationHandler: {tf in
            //tf.text = self.arrQuestion[index].question
            var changed: String = self.arrQuestion[index].question
            tf.text = changed
        })

        for item in 0...(self.arrQuestion[index].answer.count - 1) {
            switch item {
            case 0:
                let answer1TF = alert.addTextField(configurationHandler: {tf in
                    tf.text = self.arrQuestion[index].answer[item]
                    print("answer 1 - \(tf.text)")
                })
            case 1:
                let answer2TF = alert.addTextField(configurationHandler: {tf in
                    tf.text = self.arrQuestion[index].answer[item]
                    print("answer 1 - \(tf.text)")
                })
            case 2:
                let answer3TF = alert.addTextField(configurationHandler: {tf in
                    tf.text = self.arrQuestion[index].answer[item]
                    print("answer 1 - \(tf.text)")
                })
            case 3:
                let answer4TF = alert.addTextField(configurationHandler: {tf in
                    tf.text = self.arrQuestion[index].answer[item]
                    print("answer 1 - \(tf.text)")
                })
            default: break
            }
            
        }
        
        let changeQuestion = UIAlertAction(title: "Change question:", style: .default, handler: { ch in
            let question_tf = alert.textFields?.first
            let answer1_tf = alert.textFields![1]
            let answer2_tf = alert.textFields![2]
            let answer3_tf = alert.textFields![3]
            let answer4_tf = alert.textFields![4]
            
            changedQuestion = (question_tf?.text)!
            changeAnswer1 = (answer1_tf.text)!
            changeAnswer2 = (answer2_tf.text)!
            changeAnswer3 = (answer3_tf.text)!
            changeAnswer4 = (answer4_tf.text)!
            print("alertChangeQuestion2 - \(self.arrQuestion[index].question)")
            print("changedQuestion - \(changedQuestion)")
            questionTF
            if changedQuestion != "" {
                self.arrQuestion[index].question = changedQuestion
                self.myTableView.reloadData()
            }
            
            for item in 0...(self.arrQuestion[index].answer.count - 1){
                switch item {
                case 0:
                    if changeAnswer1 != ""{
                        self.arrQuestion[index].answer[item] = changeAnswer1
                        print("changeAnswer1 - \(changeAnswer1)")
                    }
                case 1:
                    if changeAnswer2 != ""{
                        self.arrQuestion[index].answer[item] = changeAnswer2
                        print("changeAnswer1 - \(changeAnswer1)")
                    }
                case 2:
                    if changeAnswer3 != ""{
                        self.arrQuestion[index].answer[item] = changeAnswer3
                        print("changeAnswer1 - \(changeAnswer1)")
                    }
                case 3:
                    if changeAnswer4 != ""{
                        self.arrQuestion[index].answer[item] = changeAnswer4
                        print("changeAnswer1 - \(changeAnswer1)")
                    }
                default:
                    break
                }
            }
        })

        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(changeQuestion)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrQuestion.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as! ExampleTableViewCell
        
        cell.questionLabel?.text = arrQuestion[indexPath.row].question
        
        for item in 0...(cell.segmentAnswerOutlet.numberOfSegments - 1) {
            cell.segmentAnswerOutlet.setTitle(arrQuestion[indexPath.row].answer[item], forSegmentAt: item)
        }
        
        cell.deligate = self
        
        cell.configure(with: indexPath.row)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.beginUpdates()
//
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            arrQuestion.remove(at: indexPath.row)
//            //self.delegate?.update(arrMessage: arrQuestion)
//            tableView.endUpdates()
//        }
//    }
}

struct Question {
    var question: String
    var answer: [String]
    var trueAnswer: [Int]
}

