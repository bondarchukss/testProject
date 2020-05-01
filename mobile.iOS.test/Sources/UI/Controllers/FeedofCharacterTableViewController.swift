//  
//  mobile.iOS.test
//  Created by Sergey Bondarchuk on 13.02.2020.
//  Copyright © 2020 Sergey Bondarchuk. All rights reserved.
import UIKit
import Moya
import Kingfisher
class FeedofCharacterTableViewController: UITableViewController {
    var viewModels = [CharacterCellViewModel]()
    let rickAndMorty = MoyaProvider<RickAndMorty>()
    let logger = Logger()
    var selectedCell: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FeedofCharacterCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = 150.0
        rickAndMorty.request(.listOfCharacter) { result in
            switch result {
            case .success(let response):
                let characterDTO = try? response.map(RickandMortyDTO.self)
                self.viewModels = characterDTO!.results.map(CharacterCellViewModel.init)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                       for: indexPath) as? FeedofCharacterCell else {
                                                        return UITableViewCell()
        }
        cell.configure(vm: viewModels[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverVC = segue.destination as? DetailInfo
        guard let selCell = selectedCell, let recVC = receiverVC else {
            return
        }
        recVC.idOfProfile = viewModels[selCell].id}
}
