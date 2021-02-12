//
//  FlightListView.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 11/02/21.
//

import SwiftUI

struct FlightListView: View {
    @ObservedObject var interactor = FlightListInteractor()
    private var origin: String = ""
    private var destination: String = ""
    private var departure: String = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(interactor.quotes ?? []) { quotes in
                    CellView(quotes: quotes, interactor: interactor)
                }
            }
        }.navigationBarTitle("Flights List").onAppear(perform: {
            interactor.callAPIToGetFlights(originCode: origin, destinationCode: destination, departure: departure)
        })
        .navigationBarItems(trailing: Button(action: {
        }) {
            Text("Filter")
        })
    }
    
    public mutating func setData(originCode: String, destinationCode: String, departure: String) {
        self.origin = originCode
        self.destination = destinationCode
        self.departure = departure
    }
}

struct CellView: View {
    var quotes: Quotes!
    var interactor: FlightListInteractor!
    
    var body: some View {
        NavigationLink(destination: FlightDetailView(quotes: quotes)) {
            HStack {
                VStack {
                    HStack {
                        Text( interactor.getFlightName(carrierId: quotes.outboundLeg?.carrierIds?.first) ?? "")
                            .foregroundColor(.blue)
                            .lineLimit(nil)
                        Spacer()
                        Text(interactor.getCurrencySymbol(quotes: quotes))
                    }
                    Spacer()
                    HStack {
                        VStack {
                            Text(interactor.getPlaceName(id: quotes.outboundLeg?.originId).0 ?? "" ).foregroundColor(.gray)
                            Text("(" + (interactor.getPlaceName(id: quotes.outboundLeg?.originId).1 ?? "") + ")" ).foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        Spacer()
                        VStack {
                            Text("------>")
                        }
                        Spacer()
                        VStack {
                            Text(interactor.getPlaceName(id: quotes.outboundLeg?.destinationId).0 ?? "" ).foregroundColor(.gray)
                            Text("(" + (interactor.getPlaceName(id: quotes.outboundLeg?.destinationId).1 ?? "") + ")" ).foregroundColor(.gray)
                                .font(.body)
                        }
                    }
                }
            }
        }
    }
}


#if DEBUG
struct FlightListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlightListView()
        }
    }
}
#endif

struct FlightDetailView: View {
    @State var quotes: Quotes
    var body: some View {
        HStack {
            Text("Departure:").foregroundColor(.gray)
            Spacer()
            Text(quotes.outboundLeg?.departureDate ?? "").foregroundColor(.gray)
                .font(.body)
        }
    }
}
