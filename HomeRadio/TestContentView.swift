//
//  ContentView.swift
//  HomeRadio
//
//  Created by Oleksandr Chornokun on 05.04.2023.
//

import SwiftUI
import Combine
import NetworkService



import RadioPlayer

class Interactor {
    var tuneInRepository: MainTuneInRepository
    var localRadioRepository: LocalRadioRepository
    
    private var subscriptions = Set<AnyCancellable>()
    
    func getMainCategories() {
        tuneInRepository.getMainTuneInCategories()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { categories in
                print(categories)
            }
            .store(in: &subscriptions)
    }
    
    func getLocalRadioStations() {
        localRadioRepository.getLocalRadioStations()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { localStations in
                print(localStations)
            }
            .store(in: &subscriptions)
    }
    
    init() {
        self.tuneInRepository = MainTuneInRepository()
        self.localRadioRepository = LocalRadioRepository()
    }
}

struct ContentView: View {
    
    let interactor = Interactor()
    
    let radio = RadioPlayer()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Button {
                radio.playRadio(from: URL(string: "https://opml.radiotime.com/Tune.ashx?id=t102329526&sid=p2182&filter=p:topic")!)
            } label: {
                Text("Play")
            }
        }
        .padding()
        .onAppear {
            interactor.getLocalRadioStations()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
