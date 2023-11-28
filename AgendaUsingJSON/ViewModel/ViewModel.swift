//////
//////  ViewModel.swift
//////  AgendaUsingJSON
//////
//////  Created by MUNAVAR PM on 27/11/23.
//////
////
////import Foundation
////
////
////let api_URl = "http://eventowl.net:3680/your/api/endpoint"
////func postData(apiUrl: String, parameters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
////    guard let url = URL(string: apiUrl) else {
////        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
////        return
////    }
////
////    var request = URLRequest(url: url)
////    request.httpMethod = "POST"
////    
////    do {
////        request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
////    } catch {
////        completion(.failure(error))
////        return
////    }
////    
////    // Add any headers if needed
////    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////
////    let task = URLSession.shared.dataTask(with: request) { data, response, error in
////        if let error = error {
////            completion(.failure(error))
////            return
////        }
////
////        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
////            completion(.failure(NSError(domain: "Server Error", code: 0, userInfo: nil)))
////            return
////        }
////
////        if let data = data {
////            completion(.success(data))
////        } else {
////            completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
////        }
////    }
////
////    task.resume()
////}
////let apiUrl = "http://eventowl.net:3680/your/api/endpoint"
////let parameters: [String: Any] = ["key1": "value1", "key2": "value2"]
////
//////postData(apiUrl: apiUrl, parameters: parameters) { result in
//////    switch result {
//////    case .success(let data):
//////        // Handle successful response data
//////        print("Response data: \(String(data: data, encoding: .utf8) ?? "")")
//////    case .failure(let error):
//////        // Handle error
//////        print("Error: \(error)")
//////    }
//////}
////
//
//
////
//
//import Foundation
//
////let api_URL = "http://eventowl.net:3680/demo_agneda_list"
////let parameters: [String: Any] = [
////    "eid": 1989,
////    "pid": 117195
////]
//
    
//
//
//print(postData())
//
//
//
////cc.postData(apiUrl: api_URL, parameters: parameters, completion: )
//
//
//
//
//
//


import Foundation

@MainActor
class DataViewModel: ObservableObject {
    
    @Published var dataArray: AgendaResponse?
    @Published var agendas: PostData?
    @Published var length: Int?
    
    init() {
        self.fetchData()
        self.postData()
        
    }
    
    
    func fetchData(){
        guard let dataURL = URL(string:"http://eventowl.net:3680/demo_agenda_detail?sid=1&eid=1989&pid=117195&aid=25857") else { return }
            Task{
                do{
                    let (data,_) = try  await URLSession.shared.data(from: dataURL)
                        let decoder = JSONDecoder()
                        let agendaResponse = try decoder.decode(AgendaResponse.self, from: data)
                        self.dataArray = agendaResponse
                }catch{
                    print(error.localizedDescription+"agendaData")
                }
            }
        }
    
    func postData() {

        let api_URL = "http://eventowl.net:3680/demo_agneda_list"
        let parameters: [String: Any] = ["eid": 1989, "pid": 117195]

        guard let url = URL(string: api_URL) else {
            print("url error")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Set the content type
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        // Convert parameters to data
        let bodyString = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            if let error = error {
                print(error)
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print(response ?? "")
                return
            }

            if let datas = data {
                do {
                    let decoder = JSONDecoder()
                    let agendasPost = try decoder.decode(PostData.self, from: datas)
                    self.agendas = agendasPost
                   
                    self.length = agendas?.data.count ?? 0
                    print("\(self.length)✅heloooooo")
                    // Now you can use agendaResponse for further processing
                    print(agendasPost)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else {
                print("No data received")
            }
        }

        task.resume()
      
        
    }
}
