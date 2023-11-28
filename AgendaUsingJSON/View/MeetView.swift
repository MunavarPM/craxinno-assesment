//
//  MeetView.swift
//  AgendaUsingJSON
//
//  Created by MUNAVAR PM on 27/11/23.
//

import SwiftUI

struct MeetView: View {
    @Environment (\.dismiss) var dismiss
    let longTextThreshold: Double = 0.75
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Image(.meetImg)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.top)
                    VStack {
                        Text("Northwest Florid Reception Sponsored by Beggs & Lane RLLP")
                            .font(.custom("Poppins-Medium", size: 20))
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.leading)
                            .lineLimit(textIsLong ? nil : 1)
                            .padding(10)
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        ImageCircleView()
                        HStack {
                            Image(systemName: "mappin")
                                .foregroundStyle(.blue)
                            VStack {
                                Text("January 10.00 PM")
                                    .font(.custom("Poppins-Medium", size: 17))
                            }
                            
                        }
                        VStack {
                            VStack {
                                Text("10.00 PM")
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundStyle(.blue)
                            VStack {
                                Text("January 10.00 PM")
                                    .font(.custom("Poppins-Medium", size: 17))
                            }
                            
                        }
                        VStack {
                            VStack {
                                Text("10.00 PM")
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            CustomBF(text: "Enter Code", width: 170, action: {})
                            Spacer()
                            CustomBF(text: "Take Survey", width: 170, action: {})
                        }
                        
                        Text("Speaker")
                            .font(.custom("Poppins-Medium", size: 18))
                            .padding(.top)
                        
                            ForEach(0 ..< 4){ _ in
                                CustomSpeakersView()
                            }
                        
                        Text("Registration Link")
                            .font(.custom("Poppins-Medium", size: 18))
                            .padding(.top)
                        CustomBF(text: "Craxinno Technologies", width: 300, action: {})
                            .padding(.horizontal, 30)
                        Text("Registration Link")
                            .font(.custom("Poppins-Medium", size: 18))
                            .padding(.top)
                        CustomBF(text: "Feature List (DOC)", width: 300, action: {})
                            .padding(.horizontal, 30)
                        
                        Text("Discription")
                            .font(.custom("Poppins-Medium", size: 18))
                            .padding(.top)
                        
                        Text("but if you can’t wait that long, a free demo, which is a prologue for the main story, is available right now. It takes place a few weeks before the events of Alone in the Dark and doesn’t have any of the combat of the main game, but it should give you an interactive taste of what to expect. Here are all the demo links:")
                        
                        Text("Sponser Name")
                            .font(.custom("Poppins-Medium", size: 18))
                            .padding(.top)
                        
                        
                            HStack(alignment: .center) {
                                Image("DP")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                                    .frame(width: 100, height: 100)
                                Text("Apple")
                                    .font(.custom("Poppins-Medium", size: 35).bold())
                            }
                            .padding(.horizontal, 50)
                        
                    }
                    .padding(.horizontal)
                    
                }
            }
            .edgesIgnoringSafeArea(.top)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }, label: {
                        Image(systemName: "arrow.backward.circle")
                            .font(.title)
                            .foregroundStyle(.white)
                    })
                }
            })
        }
        .navigationBarBackButtonHidden(true)
    }
    private var textIsLong: Bool {
            let textLength = "Northwest Florid Reception Sponsored by Beggs & Lane RLLP".count
            let maxLength = Int(Double(textLength) * longTextThreshold)
            return textLength > maxLength
        }
}

#Preview {
    MeetView()
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
    var body: some View {
        HStack {
            Image("DP")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color(red: 0, green: 0.4, blue: 0.67), lineWidth: 2)
                )
            VStack(alignment: .leading) {
                Text("Munavar")
                    .font(.custom("Poppins-Medium", size: 17))
                Text("App Innovation")
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundStyle(.gray)
            }
        }
    }
}
