//
//  ToDo.swift
//  Navigation
//
//  Created by Сергей Минеев on 9/3/24.
//
import Foundation

struct Todo: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
