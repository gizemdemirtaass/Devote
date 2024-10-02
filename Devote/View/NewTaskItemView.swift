//
//  NewTaskItemView.swift
//  Devote
//
//  Created by gizem demirtas on 1.10.2024.
//

import SwiftUI

struct NewTaskItemView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @Environment(\.managedObjectContext) private var viewContext //Öğe ekleme işlevinin çalışması için gerekli olan yönetilen nesne bağlamına erişim elde ederiz.
    @State private var task: String = ""
    
    //İçerik görünümü ile bu görünümün birbiriyle iletişim kurmasını sağlamamız gerekiyor.
    //Bağlayıcı bir özellik sarmalayıcı ile ve herhangi bir başlangıç değeri olmadan yeni bir özellik oluşturduk.
    @Binding var isShowing: Bool
    
    
    
    private var isButtonDisabled: Bool { //Task ı girdiğimiz alan boş mu                                     diye kontrol ediyor
        task.isEmpty
    }
    
    // MARK: - ADD FUNCTION
    /*
     addItem Fonksiyonu
     addItem(): Bu fonksiyon, bir öğe ekler. Kullanıcı Add butonuna tıkladığında çalışır.
     Yeni bir Item nesnesi oluşturulur (Item(context: viewContext)), ve timestamp alanı şu anki tarih ve saat ile doldurulur.
     try viewContext.save(): Veriler Core Data'ya kaydedilir. Eğer bir hata oluşursa, hata catch bloğunda yakalanır ve uygulama durdurularak hata raporu gösterilir.
     */
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            VStack (spacing: 16){
                TextField ("New Task", text: $task)
                    .foregroundColor(Color.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground)
                    )
                    .cornerRadius(10)
                    .padding()
                Button(action: {
                    addItem()
                    playSound(sound: "sound-rise", type: "mp3")
                }, label: {
                    Spacer()
                    Text("Save")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled) //Devre dışı bırak kodudur!
                .onTapGesture {
                    if (isButtonDisabled) {
                        playSound(sound: "sound-tap", type: "mp3")
                        feedback.notificationOccurred(.success)
                    }
                }
                .padding()
                .foregroundColor(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .cornerRadius(10)
                .padding(.horizontal)
                
            } //: VSTACK
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(
                //Ternary Operator - SwiftUI Conditional Modifier
                //Koşul ? koşul doğru ise : koşul yanlış ise
                isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white
            )
            .cornerRadius(16)
            .shadow(color: Color(red : 0 , green: 0, blue: 0, opacity: 0.65), radius: 24)
            .frame(maxWidth: 640)
        } //:VSTACK
        .padding()
    }
}

    // MARK: - PREVIEW
#Preview {
    NewTaskItemView(isShowing: .constant(true))
        .background(Color.gray.edgesIgnoringSafeArea(.all))
}
