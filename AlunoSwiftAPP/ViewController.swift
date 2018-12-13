import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var alunoTableview: UITableView!
    let endpoint = "https://gilsonpolito-api.herokuapp.com/alunos"
    
    var alunos = [[String:AnyObject]]()
    private let refresh = UIRefreshControl()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.alunos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.alunoTableview.dequeueReusableCell(withIdentifier: "aluno", for: indexPath) as! AlunoTableViewCell
        var dict = alunos[indexPath.row]
        cell.lblNome.text = dict["nome"] as? String
        cell.lblNota.text = dict["nota"]?.stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let dict = self.alunos[indexPath.row]
            let deleteEndpoint = self.endpoint + "/" + (dict["id"]?.stringValue!)!
            
            Alamofire.request(deleteEndpoint, method: .delete)
                .responseJSON { response in
                    guard response.result.error == nil else {
                        if let error = response.result.error {
                            let alert = UIAlertController(title: "Falha", message: "Erro ao executar chamada na API\(error)", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                        return
                    }
                    self.atualizarTela()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alunoTableview.dataSource = self
        self.alunoTableview.delegate = self
    }
    
    func atualizarTela(){
        self.refresh.addTarget(self, action: #selector(getAlunos(_:)), for: .valueChanged)
        self.alunoTableview.refreshControl = self.refresh
        self.getAlunos(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.atualizarTela()
    }

    @objc private func getAlunos(_ sender: Any){
        Alamofire.request(self.endpoint, method: .get).responseJSON{(responseData) -> Void in
            let alunoJSON = JSON(responseData.result.value!)
            self.alunos = alunoJSON.arrayObject as! [[String:AnyObject]]
            if self.alunos.count > 0 {
                self.alunoTableview.reloadData()
            }
            self.refresh.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "novoAluno", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "novoAluno" {
            let indexPaths = self.alunoTableview!.indexPathsForSelectedRows!
            let indexPath = indexPaths[0] as NSIndexPath
            let vc = segue.destination as! NovoAlunoViewController
            let dict = self.alunos[indexPath.row]
            
            vc.aluno = Aluno(alunoId: (dict["id"]?.stringValue)!
                                , alunoNome: dict["nome"] as! String
                                , alunoSite: dict["site"] as! String
                                , alunoEndereco: dict["endereco"] as! String
                                , alunoNota: (dict["nota"]?.stringValue)!
                                , alunoTelefone: dict["telefone"] as! String)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
