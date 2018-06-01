import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var interactionHandler = InteractionHandler()
        
        let keywords = ["Hosta", "hostar", "andas", "andning", "andetag", "snuva", "snuvig", "förkylning", "förkyld", "flåsar", "flämta", "pusta", "hals", "halsen", "halsont"]
        
        for keyword in keywords {
            interactionHandler.newInteraction(interaction: Interaction(keyword: keyword, answer: "Ok! Detta är hur jag skulle sammanfatta din hälsa just nu. Du har problem med: \n - hosta \n - snuva \n - eventuellt allergi \n\n Har jag förstått rätt? \n Ja eller Nej?", type: .throat))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

