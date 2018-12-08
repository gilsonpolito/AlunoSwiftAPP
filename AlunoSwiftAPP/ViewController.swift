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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alunoTableview.dataSource = self
        self.alunoTableview.delegate = self
        self.refresh.addTarget(self, action: #selector(getAlunos(_:)), for: .valueChanged)
        self.alunoTableview.refreshControl = self.refresh
        self.getAlunos(self)
    }

    @objc private func getAlunos(_ sender: Any){
        Alamofire.request("https://gilsonpolito-api.herokuapp.com/alunos", method: .get).responseJSON{(responseData) -> Void in
            let alunoJSON = JSON(responseData.result.value!)
            self.alunos = alunoJSON.arrayObject as! [[String:AnyObject]]
            if self.alunos.count>0{
                self.alunoTableview.reloadData()
            }
            self.refresh.endRefreshing()
        }
    }
}
