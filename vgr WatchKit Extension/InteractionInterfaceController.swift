import WatchKit
import Foundation

class InteractionInterfaceController: WKInterfaceController {
    var interactionHandler = InteractionHandler()
    var currentInteraction: Interaction?
    var showingGenericAnswer = false
    
    @IBOutlet var answerLabel: WKInterfaceLabel!
    @IBOutlet var buttonsGroup: WKInterfaceGroup!
    
    
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

    @IBAction func yesTapped() {
        buttonsGroup.setHidden(true)
        
        if showingGenericAnswer {
            startListening()
        } else {
            scroll(to: answerLabel, at: .top, animated: false)
            answerLabel.setText("Ok!\n Baserat på din berättelse drar jag följande slutsatser: \n1. Så länge hostan inte är svår och slemmig i flera dagar behöver du inte oroa dig för KOL-sjukdom.\n2. Om hostan inte ger med sig om en vecka så uppsök jourmottagning.\n3. Boka en allergiutredning hos din vårdcentral")
        }
    }
    
    @IBAction func noTapped() {
        if showingGenericAnswer {
            popToRootController()
        } else {
            startListening()
        }
    }
    
    // THIS SHOULD LATER BE SENT FROM PHONE
    func setUpInteractions() {
        let keywords = ["testing", "Hosta", "hostar", "andas", "andning", "andetag", "snuva", "snuvig", "förkylning", "förkyld", "flåsar", "flämta", "pusta", "hals", "halsen", "halsont"]
        
        for keyword in keywords {
            interactionHandler.newInteraction(interaction: Interaction(keyword: keyword, answer: "Ok! Detta är hur jag skulle sammanfatta din hälsa just nu. Du har problem med: \n - hosta \n - snuva \n - eventuellt allergi \n\nHar jag förstått rätt?"))
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
                
                self.buttonsGroup.setHidden(false)
                self.updateQuestions(result)
            } else {
                self.answerLabel.setText(nil)
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
        
        showingGenericAnswer = (foundInteraction.keyword == "generic")
        currentInteraction = foundInteraction
    }
    
    private func showAnswer() {
        if let interaction = currentInteraction {
            answerLabel.setText(interaction.answer)
        }
    }
    
}
