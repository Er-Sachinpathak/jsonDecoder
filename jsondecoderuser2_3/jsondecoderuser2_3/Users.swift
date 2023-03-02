//
//  Users.swift
//  jsondecoderuser2_3
//
//  Created by Mac on 02/03/23.
//

import Foundation
struct Users : Decodable{
    var id : Int
    var name : String
    var city : String
    var lat : String
    var lng : String
    
    enum MainContanierKey : CodingKey{
    case id,name,address
    }
    enum adressContainerKey : CodingKey{
        case city
        case geo
    }
    enum geoContainerKey : CodingKey{
        case lat, lng
    }
    
    init(from decoder: Decoder) throws {
        let mainContainer = try! decoder.container(keyedBy: MainContanierKey.self)
        id = try! mainContainer.decode(Int.self, forKey: .id)
        name = try! mainContainer.decode(String.self, forKey: .name)
       // adress = try! mainContainer.decode(String.self, forKey: .adress)
   
        let adressContainer = try! mainContainer.nestedContainer(keyedBy: adressContainerKey.self, forKey: .address)
        city = try! adressContainer.decode(String.self, forKey: .city)
        
    
        let geoContainer = try! adressContainer.nestedContainer(keyedBy: geoContainerKey.self, forKey: .geo)
        lat = try geoContainer.decode(String.self, forKey: .lat)
        lng =  try geoContainer.decode(String.self, forKey: .lng)
        
    }
}
