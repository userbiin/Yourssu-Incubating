//
//  ContentView.swift
//  Navigation Controller, Navigation Controller, Segue
//
//  Created by Subin on 5/12/26.
//
import SwiftUI


struct Board: Identifiable {
    let id = UUID()
    let title: String
    let content: String
}


struct EachMemoCell: View{
    let board: Board
    
    var body: some View{
        VStack{
            Text(board.title)
            Text(board.content)
                .font(.caption)
                .foregroundColor(Color(.systemGray))
        }
        
    }
}



struct MainView: View {
    @State var list: [Board] = []
    @State var current: Bool = false
    
    var body: some View {
        NavigationStack{
            
            if (list.isEmpty){
                Text("메모가 없습니다.")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .frame(width: 200, height: 600, alignment: .center)
                    .foregroundColor(Color(.systemGray))
            }
            
            List(list) {
                item in
                NavigationLink(destination: ReadDetailView(board: item)) { EachMemoCell(board: item) }
            }
            .navigationTitle("메모 목록")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        current = true
                    } label: { Image(systemName: "plus") }
                }
            }
            .navigationDestination(isPresented: $current){
                DetailView(list : $list) }
        }
    }
    
}

struct ReadDetailView: View {
    let board: Board
    @Environment(\.dismiss) var dismiss
    
    var body: some View{
        VStack(spacing: 30) {
            Text(board.title)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color(.systemGray))
                .frame(width: 340, height: 35, alignment: .leading)
                .padding(10)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
            Text(board.content)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color.black)
                .frame(width: 310, height: 500, alignment: .leading)
                .padding(30)
                .background(Color(.white))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
        }.navigationTitle("메모 조회")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button("메모 목록"){
                        dismiss()
                    }
                }
            }
    }
}


struct DetailView: View {
    @Binding var list: [Board]
    @State var title: String = ""
    @State var content: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 30){
            TextField("제목 입력", text: $title)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color(.systemGray))
                .frame(width: 340, height: 35, alignment: .leading)
                .padding(10)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
            TextEditor(text: $content)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color.black)
                .frame(width: 310, height: 500, alignment: .leading)
                .padding(30)
                .background(Color(.white))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .shadow(radius: 5)
            
        }.navigationTitle("메모 작성")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("등록"){
                        list.append(Board(title: title, content: content))
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    Button("메모 목록"){
                        dismiss()
                    }
                }
            }
    }
}

struct ContentView: View {
    var body: some View {
        MainView()
    }
}


#Preview {
    ContentView()
}
