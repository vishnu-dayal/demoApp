//
//  FlightListView.swift
//  DemoApp
//
//  Created by Vishnu Dayal on 11/02/21.
//

import SwiftUI

struct FlightListView: View {
    @ObservedObject var interactor = FlightListInteractor()
    @EnvironmentObject var presenter: FlightListPresenter
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.gray]
        UITableViewCell.appearance().backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                List {
                    ForEach(interactor.quotes ?? []) { quotes in
                        CellView(quotes: quotes, interactor: interactor).clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            }
        }.navigationBarTitle("Flights").onAppear(perform: {
            interactor.callAPIToGetFlights()
            interactor.callListOfCountriesAPI()
            interactor.callListOfCurrenciesAPI()
        })
        .navigationBarItems(trailing: Button(action: {
        }) {
            Text("Filter")
        })
        
    }
}

struct MyHeader: View {
    var body: some View {
        Text("Flights").foregroundColor(.blue)
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
                        Spacer() // help to align the title in the left
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
                    Spacer()
                    HStack {
                        Text("Departure:").foregroundColor(.gray)
                        Spacer()
                        Text(quotes.outboundLeg?.departureDate ?? "").foregroundColor(.gray)
                            .font(.body)
                    }
                }
            }.padding()
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
        VStack {
            Text(verbatim: quotes.outboundLeg?.departureDate ?? "")
        }
    }
}
