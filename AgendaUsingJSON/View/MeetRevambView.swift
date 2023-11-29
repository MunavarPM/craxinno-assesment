//
//  SwiftUIView.swift
//  AgendaUsingJSON
//
//  Created by MUNAVAR PM on 28/11/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MeetRevambView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: DataViewModel
    let longTextThreshold: Double = 0.75
    let screenWidth = UIScreen.main.bounds.width
    let id: Int
    init(id: Int) {
        self.id = id
    }
    private var textIsLong: Bool {
        let textLength = "Northwest Florid Reception Sponsored by Beggs & Lane RLLP".count
        let maxLength = Int(Double(textLength) * longTextThreshold)
        return textLength > maxLength
    }
    var body: some View {
        
        VStack(alignment: .leading, spacing: 22) {
            header
            Group {
                if let speakers = viewModel.dataArray?.data?.agenda_speakers {
                    ImageCircleView(imageURLs: speakers.map { $0.image ?? ""})
                }
                renderCell(
                    image: "mappin",
                    text: viewModel.dataArray?.data?.location_name ?? "Default Location",
                    description: eventDuration(viewModel.dataArray?.data?.start_date ?? "",
                                               endDate: viewModel.dataArray?.data?.end_date ?? "")
                )
                renderCell(
                    image: "calendar",
                    text: formateDate(viewModel.dataArray?.data?.start_date ?? "").formatDate(.mmmddyyy),
                    description: eventDuration(viewModel.dataArray?.data?.start_date ?? "",
                                               endDate: viewModel.dataArray?.data?.end_date ?? "")
                )
            }
            .padding(.horizontal, 33)
            Spacer()
            
        }
        .task {
           // viewModel.fetchData()
        }
        .ignoresSafeArea()
    }
    private func formateDate(_ dateString: String) -> Date {
       return dateString.convertUTCStringToDate(.utcFormat)
        
    }
    private func eventDuration(_ startDate: String, endDate: String) -> String {
        let start = startDate.convertUTCStringToDate(.utcFormat)
        let end = startDate.convertUTCStringToDate(.utcFormat)
        return "\(start.formatDate(.hmma)) - \(end.formatDate(.hmma))"
    }
    @ViewBuilder private var header: some View {
        ZStack(alignment: .topLeading) {
            
            VStack {
                let commonPath = viewModel.dataArray?.imgPath
                let imgPath = viewModel.dataArray?.data?.header_img
                
                let path = commonPath! + imgPath!
                WebImage(url: URL(string:path))
                    .resizable()
                 //   .placeholder(Image("MeetImg"))
                    .frame(width: screenWidth, height: screenWidth * 0.77)
                    .aspectRatio(1.3, contentMode: .fill)
                Text(viewModel.dataArray?.data?.name ?? "") 
                
                    .font(.custom("Poppins-Medium", size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.black)
                    .lineLimit(textIsLong ? nil : 1)
                    .padding(.leading, 32)
                    .padding(.trailing, 80)
                Spacer()
            }
            Button(action: { dismiss() }, label: {
                Image(systemName: "arrow.backward.circle")
                    .font(.title)
                    .foregroundStyle(.white)
            })
            .padding(.top, 44)
            .padding(.leading, 18)
        }
    }
    @ViewBuilder private func renderCell(image: String, text: String, description: String) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            Image(systemName: image)
                .foregroundStyle(.blue)
                .frame(width: 18, height: 18, alignment: .center)
            VStack(alignment: .leading, spacing: 4) {
                Group {
                    Text(text)
                    Text(description)
                        .foregroundStyle(.gray)
                }
                .font(.custom("Poppines-Medium", size: 16))
                .fontWeight(.medium)
            }
            
        }
    }
}

#Preview {
    MeetRevambView(id: 25860)
}
enum DateFormat: String {
    case EEEddMMM = "EEE, dd MMM"
    case EEEddMMMyyyy = "EEEE, dd MMMM yyyy"
    case HHmmss = "HH:mm:ss"
    case hmma = "h:mm a"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case dMMMMyyyy_hmma = "d MMMM yyyy - h:mm a"
    case yyyyMMdd = "yyyy-MM-dd"
    case mmmddyyy = "MMM dd, yyyy"
    case utcFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case ddmmmyyyy = "dd-MMM-yyyy"
    case dd_MMM_yyyy = "dd MMM yyyy"
    case ddMMM = "dd MMM"
    case ddMMyyyy = "dd/MM/yyyy"
}
extension Date {
    func formatDate(_ type: DateFormat, timeZone: TimeZone? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type.rawValue
        if let timeZone = timeZone {
            dateFormatter.timeZone = timeZone
        }
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

extension String {
    func convertUTCStringToDate(_ type: DateFormat, timeZone: TimeZone? = nil) -> Date {
        let dateString = self
        let formatter = DateFormatter()
        formatter.dateFormat = type.rawValue
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        guard let date = formatter.date(from: dateString) else { return Date() }
        return date
    }
}

