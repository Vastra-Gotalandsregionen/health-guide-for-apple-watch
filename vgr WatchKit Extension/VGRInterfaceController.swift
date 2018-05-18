import WatchKit
import Foundation


class VGRInterfaceController: WKInterfaceController {
    var interactionHandler = InteractionHandler()
    var currentInteraction: Interaction?
    var questions = [String]()
    
    @IBOutlet var answerLabel: WKInterfaceLabel!
    @IBOutlet var historyTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        setUpInteractions()
     
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    override func didAppear() {
        showAnswer()
        setupTable()
    }
    
    // THIS SHOULD LATER BE SENT FROM PHONE
    func setUpInteractions() {
        let keywords = ["testing", "Hosta", "hostar", "andas", "andning", "andetag", "snuva", "snuvig", "förkylning", "förkyld", "flåsar", "flämta", "pusta", "hals", "halsen", "halsont"]
        
        for keyword in keywords {
            interactionHandler.newInteraction(interaction: Interaction(keyword: keyword, answer: "Ok! Detta är hur jag skulle sammanfatta din hälsa just nu. Du har problem med: \n - hosta \n - snuva \n - eventuellt allergi \n\n Har jag förstått rätt? \n Ja eller Nej?"))
        }
    }

    @IBAction func startListening() {
        presentTextInputControllerWithSuggestions(forLanguage: { (inputLanguage) -> [Any]? in
            print(inputLanguage)
            return nil
        }, allowedInputMode: .plain) { (results) in
            if let result = results?.first as? String {
                self.questions.append(result)
                self.updateInteraction(question: result)
            }
        }
    }
    
    private func updateInteraction(question: String) {
        guard let foundInteraction = self.interactionHandler.findInteraction(question: question) else {
            return
        }
        currentInteraction = foundInteraction
    }
    
    private func showAnswer() {
        if let interaction = currentInteraction {
            answerLabel.setText(interaction.answer)
        }
    }
}

extension VGRInterfaceController {
    
    func setupTable() {
        historyTable.setNumberOfRows(questions.count, withRowType: "HistoryTableRowController")
        
        for index in 0..<questions.count {
            let question = questions[index]
            let row = historyTable.rowController(at: index) as! HistoryTableRowController
            row.historyLabel.setText(question)
        }
    }
}
