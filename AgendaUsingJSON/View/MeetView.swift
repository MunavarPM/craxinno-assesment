//
//  MeetView.swift
//  AgendaUsingJSON
//
//  Created by MUNAVAR PM on 27/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MeetView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: DataViewModel
    let id: Int
    
    
    let longTextThreshold: Double = 0.75
    var body: some View {
        
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    if viewModel.fetchData(id: id){
                    
                        MeetRevambView(id: id)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack {
                                CustomBF(text: "Enter Code", width: 170, action: {
                                    
                                    viewModel.postData()
                                    
                                })
                                Spacer()
                                CustomBF(text: "Take Survey", width: 170, action: {})
                            }
                            
                            Text("Speaker")
                                .font(.custom("Poppins-Medium", size: 18))
                                .padding(.top)
                            
                            ForEach(viewModel.dataArray?.data?.agenda_speakers ?? [], id: \.self) { speaker in
                                CustomSpeakersView(image: speaker.image, name: speaker.name, domain: speaker.company_name)
                            }
                            
                            Text("Registration Link")
                                .font(.custom("Poppins-Medium", size: 18))
                                .padding(.top)
                            CustomBF(text: viewModel.dataArray?.data?.register_links?[0].register_text ?? "", width: 300, action: {
                                if let urlString = viewModel.dataArray?.data?.register_links?[0].register_link,
                                   let url = URL(string: urlString) {
                                    UIApplication.shared.open(url)
                                }
                            })
                            
                            .padding(.horizontal, 30)
                            Text("Registration Link")
                                .font(.custom("Poppins-Medium", size: 18))
                                .padding(.top)
                            CustomBF(text: viewModel.dataArray?.data?.agenda_documents?[0].document_name ??  "", width: 300, action: {
                                if let urlString = viewModel.dataArray?.data?.agenda_documents?[0].document_file,
                                   let url = URL(string: urlString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                            )
                            .padding(.horizontal, 30)
                            
                            Text("Discription")
                                .font(.custom("Poppins-Medium", size: 18))
                                .padding(.top)
                            
                            Text("but if you can’t wait that long, a free demo, which is a prologue for the main story, is available right now. It takes place a few weeks before the events of Alone in the Dark and doesn’t have any of the combat of the main game, but it should give you an interactive taste of what to expect. Here are all the demo links:")
                            
                            
                            Text("Sponser Name")
                                .font(.custom("Poppins-Medium", size: 18))
                                .padding(.top)
                            
                            
                            HStack(alignment: .center) {
                                WebImage(url: URL(string: "\(viewModel.dataArray?.data?.sponsor_img ?? "Apple")"))
                                    .resizable()
                                    .placeholder(Image("Apple"))
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                                
                                Text(viewModel.dataArray?.data?.sponsor_name ?? "Apple Co.")
                                    .font(.custom("Poppins-Medium", size: 35).bold())
                            }
                            .padding(.horizontal, 90)
                            
                        }
                        .padding(.horizontal)
                    }else{
                        ProgressView()
                                            .onAppear {
                                                // Fetch data when the view appears
                                                viewModel.fetchData(id: id)
                                            }
                    }
                    
                }
                
            }
            .edgesIgnoringSafeArea(.top)
            .onAppear {
//                print(viewModel.dataArray?.data?.register_links![0].register_link ?? "")
            }
//        .navigationBarBackButtonHidden(true)
    }
    private var textIsLong: Bool {
        let textLength = "Northwest Florid Reception Sponsored by Beggs & Lane RLLP".count
        let maxLength = Int(Double(textLength) * longTextThreshold)
        return textLength > maxLength
    }
}

#Preview {
    MeetView(id: 23445)
}

struct CustomBF: View {
    var text: String
    var width: CGFloat
    var action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: width, height: 48)
        .background(
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(Color(red: 0, green: 0.4, blue: 0.67))
        )
    }
}


struct CustomSpeakersView: View {
    let image: String?
    let name: String?
    let domain: String?
    var body: some View {
        HStack {
            WebImage(url: URL(string: image ?? "DP"))
                .resizable()
                .placeholder(Image("DP"))
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color(red: 0, green: 0.4, blue: 0.67), lineWidth: 2)
                )
            VStack(alignment: .leading) {
                Text(name ?? "Munavar")
                    .font(.custom("Poppins-Medium", size: 17))
                Text(domain ?? "App Innovation")
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundStyle(.gray)
            }
        }
    }
}
