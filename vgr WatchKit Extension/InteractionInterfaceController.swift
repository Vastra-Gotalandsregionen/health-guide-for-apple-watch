import WatchKit
import Foundation

class InteractionInterfaceController: WKInterfaceController {
    var interactionHandler = InteractionHandler()
    var currentInteraction: Interaction?
    
    
    @IBOutlet var answerLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        setUpInteractions()
        startListening()
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    // THIS SHOULD LATER BE SENT FROM PHONE
    func setUpInteractions() {
        let keywords = ["testing", "Hosta", "hostar", "andas", "andning", "andetag", "snuva", "snuvig", "förkylning", "förkyld", "flåsar", "flämta", "pusta", "hals", "halsen", "halsont"]
        
        for keyword in keywords {
            interactionHandler.newInteraction(interaction: Interaction(keyword: keyword, answer: "Ok! Detta är hur jag skulle sammanfatta din hälsa just nu. Du har problem med: \n - hosta \n - snuva \n - eventuellt allergi \n\n Har jag förstått rätt? \n Ja eller Nej?"))
        }
    }
    
    private func startListening() {
        presentTextInputControllerWithSuggestions(forLanguage: { (inputLanguage) -> [Any]? in
            print(inputLanguage)
            return nil
        }, allowedInputMode: .plain) { (results) in
           
            if let result = results?.first as? String {
                self.updateInteraction(question: result)
                self.showAnswer()

                self.updateQuestions(result)
            }
        }
    }
    
    private func updateQuestions(_ question: String) {
        if let vgrInterfaceController = WKExtension.shared().rootInterfaceController as? VGRInterfaceController {
            vgrInterfaceController.updateQuestions(question)
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
