import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var alunoTableview: UITableView!
    
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
            // implement delete
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alunoTableview.dataSource = self
        self.alunoTableview.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.refresh.addTarget(self, action: #selector(getAlunos(_:)), for: .valueChanged)
        self.alunoTableview.refreshControl = self.refresh
        self.getAlunos(self)
    }

    @objc private func getAlunos(_ sender: Any){
        Alamofire.request("https://gilsonpolito-api.herokuapp.com/alunos", method: .get).responseJSON{(responseData) -> Void in
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
            print(dict["nome"] as! String)
            vc.txtNome?.text = dict["nome"] as? String
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
