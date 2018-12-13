import UIKit
import Alamofire
import SwiftyJSON

class NovoAlunoViewController: UIViewController {

    @IBOutlet weak var txtNota: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtSite: UITextField!
    
    var json: Parameters = [:]
    var aluno: Aluno? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if aluno != nil {
            preencheTela()
        }
    }
    
    @IBAction func btnGravar(_ sender: Any) {
        let url = "https://gilsonpolito-api.herokuapp.com/alunos"

        var msg :String = ""
        if txtNome.text?.count == 0{
            msg += "Nome\n"
        }
        if txtEndereco.text?.count == 0{
            msg += "Endereco\n"
        }
        if txtTelefone.text?.count == 0{
            msg += "Telefone\n"
        }
        if txtSite.text?.count == 0{
            msg += "Site\n"
        }
        if txtNota.text?.count == 0{
            msg += "Nota\n"
        }
        
        if msg.count>0{
            let alert = UIAlertController(title: "Campos obrigatórios", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
       
        if aluno?.alunoId != nil {
            self.json = ["id":aluno?.alunoId as Any,"nome":txtNome.text!,"site":txtSite.text!,"telefone":txtTelefone.text!,"endereco":txtEndereco.text!, "nota":txtNota.text!]
            Alamofire.request(url, method: .put, parameters: json, encoding: JSONEncoding.default, headers:nil).responseJSON{(responseData) -> Void in
                switch responseData.result{
                case .success(_):
                    _ = self.navigationController?.popToRootViewController(animated: true)
                case .failure(_):
                    let alert = UIAlertController(title: "Falha", message: "Erro ao executar chamada na API", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        } else {
            self.json = ["id":"","nome":txtNome.text!,"site":txtSite.text!,"telefone":txtTelefone.text!,"endereco":txtEndereco.text!, "nota":txtNota.text!]
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
    
    func preencheTela(){
        txtNome.text = aluno?.alunoNome
        txtSite.text = aluno?.alunoSite
        txtEndereco.text = aluno?.alunoEndereco
        txtTelefone.text = aluno?.alunoTelefone
        txtNota.text = aluno?.alunoNota
    }
}
