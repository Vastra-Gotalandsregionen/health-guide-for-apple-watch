import WatchKit
import Foundation


class VGRInterfaceController: WKInterfaceController {
    var interactionHandler = InteractionHandler()
    var currentInteraction: Interaction?
    
    @IBOutlet var answerLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setUpInteractions()
        answerLabel.setText("test")
    }

    override func willActivate() {
        
        super.willActivate()

        showAnswer()
    }

    override func didDeactivate() {
        
        super.didDeactivate()
    }

    
    // THIS SHOULD LATER BE SENT FROM PHONE
    func setUpInteractions() {
        let keywords = ["Hosta", "hostar", "andas", "andning", "andetag", "snuva", "snuvig", "förkylning", "förkyld", "flåsar", "flämta", "pusta", "hals", "halsen", "halsont"]
        
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
                self.updateInteraction(question: result)
            }
        }
        
        //        self.presentTextInputController(withSuggestions: nil, allowedInputMode: .plain, completion: { (questions) -> Void in
        //            print(questions)
        //
        //        })
    }
    
    private func updateInteraction(question: String) {
        guard let foundInteraction = self.interactionHandler.findInteraction(question: question) else {
            return
        }
        currentInteraction = foundInteraction
    }
    
    private func showAnswer() {
        if let interaction = currentInteraction {
            print(interaction.answer)
            answerLabel.setText(interaction.answer)
        }
    }
    
}
