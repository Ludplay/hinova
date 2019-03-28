//
//  StoriesTableViewController.swift
//  OficExample
//
//  Created by LudMac on 27/03/19.
//  Copyright © 2019 LudMac. All rights reserved.
//

import UIKit

struct Headline {
    
    var id : Int
    var title : String
    var text : String
    var image : String
    
}

class StoriesTableViewController: UITableViewController {
    
    var headlines = [
        Headline(id: 1, title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: "Apple"),
        Headline(id: 2, title: "Aenean condimentum", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non.", image: "Banana"),
        Headline(id: 3, title: "In ac ante sapien", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc.", image: "Cantaloupe"),
        ]
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        let url = URL(string: "https://raw.githubusercontent.com/Ludplay/hinova/master/oficinas.json")!
        let networkProcessor = NetworkProcessor(url: url)
        
        networkProcessor.DownloadJSONFromUrl { (jsonDictionary) in
            //print(jsonDictionary)
            
            if let array = jsonDictionary as? [String: Any]
            {
                let listaOficinas = array["ListaOficinas"] as? [String: Any]
                let classeOficina = listaOficinas!["ClasseOficina"] as? [Any]
                let oficinas = classeOficina! as? [Any]
                
                /*var aux: String = ""
                for (index, name) in (oficinas?.enumerated())!
                {
                    let ofic = oficinas![index] as? [String: Any]
                    if let nome = ofic!["Nome"]{
                        print(nome)
                        var nomeString = nome as? String
                        if(aux != nomeString)
                        {
                            cell.textLabel?.text = nomeString
                            aux = nomeString!
                        }
                        //cell.textLabel?.text = nome as? String
                    }
                }*/
                
                let oficina = oficinas![indexPath.row] as? [String: Any]
                if let nome = oficina!["Nome"]{
                    print("oficina: \(nome)")
                    cell.textLabel?.text = nome as? String
                }
               
            }
        }
        
        /*let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
        let networkProcessor = NetworkProcessor(url: url)
        
        networkProcessor.DownloadJSONFromUrl { (jsonDictionary) in
            print(jsonDictionary)
            
            if let dictionary = jsonDictionary as? [String: Any] {
                if let title = dictionary["title"] as? String {
                    cell.textLabel?.text = title
                }
                
            }
            //cell.textLabel?.text = jsonDictionary["title"]
        }*/

        // Configure the cell...
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        //cell.textLabel?.text = headlines[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Oficinas"
    }

}
