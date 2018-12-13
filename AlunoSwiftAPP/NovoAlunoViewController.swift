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
        var msg :String = ""
        if txtNome.text?.count == 0{
            msg += "Nome\n"
        }
        if txtEmail.text?.count == 0{
            msg += "Email\n"
        }
        if txtEndereco.text?.count == 0{
            msg += "Endereco\n"
        }
        if txtTelefone.text?.count == 0{
            msg += "Telefone\n"
        }
        /*if txtSite.text?.count == 0{
            msg += "Site\n"
        }*/
        if txtNota.text?.count == 0{
            msg += "Nota\n"
        }
        
        if msg.count>0{
            let alert = UIAlertController(title: "Campos obrigatórios", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let json: Parameters = ["id":"","nome":txtNome.text!,"email":txtEmail.text!,"telefone":txtTelefone.text!,"endereco":txtEndereco.text!, "nota":txtNota.text!]
        Alamofire.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers:nil).responseJSON{(responseData) -> Void in
            switch responseData.result{
            case .success(_):
                _ = self.navigationController?.popToRootViewController(animated: true)
            case .failure(_):
                let alert = UIAlertController(title: "Falha", message: "Erro ao executar chamada na API", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
}
