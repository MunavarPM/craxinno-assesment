//
//  HomeView.swift
//  AgendaUsingJSON
//
//  Created by MUNAVAR PM on 27/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(Color(red: 0.98, green: 0.98, blue: 0.98)).ignoresSafeArea()
                VStack(spacing: 10) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(0 ..< 5) { _ in
                                HStack(spacing: 0) {
                                    Text("TUE,")
                                    Text("NOV")
                                    Text("01")
                                }
                            }
                            .padding(.horizontal, 13)
                        }
                        .padding()
                    }
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(0 ..< 5){ _ in
                                MeetListView()
                                    .frame(height: 185)
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
        }
    }
}

#Preview {
    HomeView()
}

struct MeetListView: View {
    @State private var contentIsLong = false
    var body: some View {
        NavigationLink(destination: MeetView()){
            GeometryReader { geo in
                VStack {
                    HStack {
                        Text("Northwest Florid Reception Sponsored by Beggs & Lane RLLP")
                            .font(.custom("Poppins-Medium", size: 20))
                            .fontWeight(.semibold)
                            .lineLimit(contentIsLong ? 1 : 3)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 32)
                            .frame(width: UIScreen.main.bounds.width , height: calculateTextHeight(category: "Category B", text: "Northwest Florid Reception Sponsored by Beggs & Lane RLLP", for: geo.size.width))
                            .offset(x: 18)
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("12:34 PM")
                                .foregroundColor(.gray)
                            
                            ImageCircleView()
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
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< 6) { _ in
                Image("DP")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            }
        }
    }
}
