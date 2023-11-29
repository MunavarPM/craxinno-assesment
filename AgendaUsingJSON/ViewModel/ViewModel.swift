

import Foundation

@MainActor
class DataViewModel: ObservableObject {
    
    @Published var dataArray: AgendaResponse?
    @Published var agendas: PostData?
    @Published var length: Int?
    
    
    var stat = false
    
    init() {
        //self.fetchData()
        self.postData()
        
    }
    
    
    func fetchData(id :Int)-> Bool{
        let strId = String(id)
        
        print("✅strId\(strId)")
       
        guard let dataURL = URL(string:"http://eventowl.net:3680/demo_agenda_detail?sid=1&eid=1989&pid=117195&aid=\(strId)") else { return false }
            Task{
                do{
                    let (data,_) = try  await URLSession.shared.data(from: dataURL)
                        let decoder = JSONDecoder()
                        let agendaResponse = try decoder.decode(AgendaResponse.self, from: data)
                        self.dataArray = agendaResponse
                    stat=true
                    print(agendaResponse)
                }catch{
                    print(error.localizedDescription+"agendaData")
                    stat = false
                }
            }
        print("statttttt🔥\(stat)")
        return stat
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
                   // print(agendasPost)
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
