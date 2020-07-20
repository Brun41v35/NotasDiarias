//
//  AnotacoesViewController.swift
//  Notas Diarias
//
//  Created by Bruno Alves da Silva on 17/07/20.
//  Copyright © 2020 Bruno Alves da Silva. All rights reserved.
//

import UIKit
import CoreData

class AnotacoesViewController: UIViewController {
    
    @IBOutlet weak var texto: UITextView!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Fazendo o texto abrir o teclado - Utilizando esse metodo estamos dizendo que o texto vai utilizar o teclado primeiro.
        self.texto.becomeFirstResponder()
        
        //Tendo acesso na classe AppDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Criand o nosso contexto
        context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func salvar(_ sender: Any) {
        
        self.salvaAnotacao()
        
        //retornar para a tela principal
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func salvaAnotacao () {
        
        //Cria objeto para anotacao
        let novaAnotacoa = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
        
        //Passando os valores
        novaAnotacoa.setValue(self.texto.text, forKey: "texto")
        
        //Salvando a informacao
        do {
            try context.save()
            
            //Criando um Alert para o usuario
            let alertController = UIAlertController(title: "Aviso", message: "Anotação salva com sucesso", preferredStyle: .alert)
            
            //Usando uma closure para fechar a tela
            let okAction = UIAlertAction(title: "Fechar", style: UIAlertAction.Style.default) {
                UIAlertAction in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        } catch {
            print("Erro ao salvar a informacao")
        }
    }
}
