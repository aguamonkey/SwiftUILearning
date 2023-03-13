//
//  CodableLearning.swift
//  SwiftUILearning
//
//  Created by Joshua Browne on 09/03/2023.
//

import SwiftUI

// the below struct is the model
// The whole MVVM archtecture is laid put below. You have the model. The View Model and the View

// Codable = decodable + encodable
struct CustomerModel: Identifiable, Codable {
    //let id = UUID().uuidString
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    // If we use Codable rather than decodable or encodable the below isn't necessary
    // There may be a reason to decode and encode
    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//
//    // The encoder is the opposite of the decoder
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
//    func getData() {
//        guard let data = getJSONData() else { return }
//        print("JSON DATA:")
//        print(data)
//        let jsonString = String(data: data, encoding: .utf8)
//        print(jsonString)
//    }

    func getData() {
        // Gathering the data
        guard let data = getJSONData() else {return}
        
        // The commented out code below is a manual way of decoding data. The code not commented out based on the model we set up is the efficient way to do things.
        // Here we decode
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print("Error decoding. \(error)")
        }
        
        
        // If we get all this data we can get a new customer
        // We manually decoded the data below
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String:Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool
//        {
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }
    }
    // Create fake JSON data:
    func getJSONData() -> Data? {
        // Here we encode to JSON
        let customer = CustomerModel(id: "78790", name: "Emily", points: 102, isPremium: false)
        let jsonData = try? JSONEncoder().encode(customer)
        
//        let dictionary: [String:Any] = [
//            "id" : "12345",
//            "name" : "Josh",
//            "points" : 7,
//            "isPremium" : true
//        ]
//
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary)
        
        
        
        return jsonData
    }
    
    
}

struct CodableLearning: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
        }
    }
}

struct CodableLearning_Previews: PreviewProvider {
    static var previews: some View {
        CodableLearning()
    }
}
