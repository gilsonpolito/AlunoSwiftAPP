import UIKit
import Alamofire
import SwiftyJSON

class NovoAlunoViewController: UIViewController {

    @IBOutlet weak var txtNota: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNome: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnGravar(_ sender: Any) {
        let url = "https://gilsonpolito-api.herokuapp.com/alunos"
        let json: Parameters = ["id":"","nome":txtNome.text!,"email":txtEmail.text!,"telefone":txtTelefone.text!,"endereco":txtEndereco.text!, "nota":txtNota.text!]
        Alamofire.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers:nil).responseJSON{(responseData) -> Void in
            switch responseData.result{
            case .success(_):
                
                //self.performSegue(withIdentifier: "listaAlunos", sender: self)
                _ = self.navigationController?.popToRootViewController(animated: true)
            case .failure(_):
                let alert = UIAlertController(title: "Falha", message: "Erro ao executar chamada na API", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
}
