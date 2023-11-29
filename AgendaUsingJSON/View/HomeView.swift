//
//  HomeView.swift
//  AgendaUsingJSON
//
//  Created by MUNAVAR PM on 27/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: DataViewModel
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color(red: 0.98, green: 0.98, blue: 0.98)).ignoresSafeArea()
                VStack(spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(0 ..< 1) { _ in
                                HStack(spacing: 0) {
                                    Text(formateDate((viewModel.agendas?.data[0].start_date) ?? "").formatDate(.EEEddMMM))
                                    Text(formateDate((viewModel.agendas?.data[0].end_date) ?? "").formatDate(.EEEddMMM))
                                }
                            }
                            .padding(.horizontal, 13)
                        }
                        .padding()
                    }
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            
            
                            
//                            ForEach(0 ..< 10) { i in
//                                VStack(alignment: .leading) {
//                                    MeetListView(index: i)
//                                        .frame(height: 185)
//                                }
//                            }
                            
                            
                            if let length = viewModel.length{
                                ForEach(0 ..< (viewModel.length ?? 2)) { i in
                                    VStack(alignment: .leading) {
                                        MeetListView(index: i)
                                            .frame(height: 185)
                                    }
                                }
                            }else{
                                ProgressView().onAppear { viewModel.postData() }
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("Agenda")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Image("DP")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                }
            }
            .onAppear {
                // viewModel.length
                //viewModel.postData()
            }
        }
    }
    private func formateDate(_ dateString: String) -> Date {
       return dateString.convertUTCStringToDate(.utcFormat)
        
    }
}

#Preview {
    HomeView()
}

struct MeetListView: View {
    @State private var contentIsLong = false
    @EnvironmentObject var viewModel: DataViewModel
    
    let index: Int
    var body: some View {
        let id = viewModel.agendas?.data[index].id
        NavigationLink(destination: MeetView(id: id ?? 0)){
            GeometryReader { geo in
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(viewModel.agendas?.data[index].name ?? "")
                            .font(.custom("Poppins-Medium", size: 20))
                            .fontWeight(.semibold)
                            .lineLimit(contentIsLong ? 1 : 3)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 42)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(width: UIScreen.main.bounds.width , height: calculateTextHeight(category: "Category B", text: "Northwest Florid Reception Sponsored by Beggs & Lane RLLP", for: geo.size.width))
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("12:34 PM")
                                .foregroundColor(.gray)
                            
                            if let imageUrl = viewModel.agendas?.data.first?.attendees.first?.image {
                                ImageCircleView(imageURLs: [imageUrl])
                            }
                            
                            
                            
                            
                        }
                        .padding(.leading, 45)
                        Spacer()
                    }
                    .offset(y: -25)
                }
                .onAppear {
                    let halfScreenWidth = UIScreen.main.bounds.width / 2
                    contentIsLong = calculateTextHeight(category: "Category B", text: "Northwest Florid Reception Sponsored by Beggs & Lane RLLP", for: geo.size.width) > halfScreenWidth
                }
                .background(CustomCardShape().fill(Color.white).overlay(CustomCardShape().stroke(Color.gray, lineWidth: 0.8)))
                .clipShape(CustomCardShape())
                .offset(x: 7)
            }
        }
        .accentColor(.black)
        
    }
    private func calculateTextHeight(category: String, text: String, for width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 17) // Adjust the font size as needed
        let nsString = NSString(string: text)
        let boundingBox = nsString.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        let totalPadding: CGFloat = 32 // Adjust total padding as needed
        
        // You can add logic here to handle different categories and adjust the height accordingly
        var height = boundingBox.height + totalPadding
        if category == "Category A" {
            // Adjust height for Category A
            height += 30
        } else if category == "Category B" {
            // Adjust height for Category B
            height += 40
        }
        
        return height
    }
}


struct ImageCircleView: View {
    var imageURLs: [String]
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(imageURLs, id: \.self) { url in
                WebImage(url: URL(string: url))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            }
        }
    }
}

