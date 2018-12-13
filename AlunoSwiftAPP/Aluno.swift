//
//  aluno.swift
//  AlunoSwiftAPP
//
//  Created by pos on 13/12/2018.
//  Copyright © 2018 pos. All rights reserved.
//

import Foundation

class Aluno {
    
    let alunoId: String!
    let alunoNome: String!
    let alunoSite: String!
    let alunoEndereco: String!
    let alunoNota: String!
    let alunoTelefone: String!
    
    init(alunoId: String, alunoNome: String, alunoSite: String, alunoEndereco: String, alunoNota: String, alunoTelefone: String) {
        self.alunoId = alunoId
        self.alunoNome = alunoNome
        self.alunoSite = alunoSite
        self.alunoEndereco = alunoEndereco
        self.alunoNota = alunoNota
        self.alunoTelefone = alunoTelefone
    }
}
