//
//  ContentView.swift
//  Devote
//
//  Created by gizem demirtas on 24.09.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
     
    
    
    // MARK: - FETCHING DATA
    /*
     @Environment(\.managedObjectContext)
     Core Data Bağlantısı:
     @Environment(\.managedObjectContext), SwiftUI'de kullanılan bir environment değişkenidir. Bu, Core Data'nın viewContext'ini içerir, yani Core Data ile veri işlemleri yapmak için gerekli olan veri yönetim context'ini sağlar.
     viewContext, veri ekleme, silme ve güncelleme işlemleri için kullanılır.
     Burada viewContext, Core Data'nın "context"ini ContentView içinde kullanmamızı sağlar.
     */
    @Environment(\.managedObjectContext) private var viewContext

    /*
     @FetchRequest
     Veri Çekme (Fetch Request):
     @FetchRequest, Core Data'dan verileri çekmek için kullanılır. Bu kodda, Item adında bir varlık (entity) çekiliyor.
     sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)]: Bu, çekilen verilerin timestamp (zaman damgası) alanına göre sıralanmasını sağlar. Ascending: En eski tarih önce gelir.
     animation: .default: Verilerin animasyonla güncellenmesini sağlar.
     FetchedResults<Item>: Core Data'dan çekilen sonuçlar items adındaki bir değişkene atanıyor. Bu items dizisi, listede gösterilecek verileri içerir.
     */
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    /*
     NavigationView ve List
     Navigasyon Yapısı:
     NavigationView, SwiftUI'de çoklu ekran navigasyonu yapmanı sağlar.
     List, her bir Item varlığını sıralı bir şekilde göstermek için kullanılır. Her bir Item, bir NavigationLink ile tıklanabilir hale gelir. Bu sayede bir öğeye tıkladığında başka bir görünüm (detay görünümü) açılır.
     ForEach(items)
     Listeleme:
     ForEach(items), Core Data'dan gelen items dizisini iterasyon ile dolaşır ve her bir öğeyi liste içinde görüntüler.
     NavigationLink: Her öğeye tıklandığında, detay sayfası olarak zaman damgasını (timestamp) içeren bir metin görüntülenir.
     item.timestamp!, formatter: itemFormatter: Zaman damgasını, belirli bir formatta göstermek için DateFormatter kullanılır. itemFormatter öğeleri tarih ve zaman biçiminde gösterir.
     
     onDelete(perform: deleteItems)
     onDelete: SwiftUI'da liste elemanlarının silinmesi için kullanılır. Kullanıcı, listeyi kaydırarak veya EditButton'a tıklayarak elemanları silebilir.
     Silme işlemi, aşağıda tanımlanmış olan deleteItems fonksiyonu aracılığıyla yapılır.
     Toolbar
     ToolbarItem: Navigasyon barındaki araçları (butonlar gibi) eklemek için kullanılır.

     EditButton(): Bu buton, listeye düzenleme moduna geçip elemanları silme gibi işlemler yapmayı sağlar.

     Add Item Butonu: Button(action: addItem), bir yeni öğe (item) eklemek için kullanılır. Kullanıcı bu butona tıkladığında yeni bir item Core Data'ya kaydedilir.
     
     */
    

    // MARK: - DELETE FUNCTION
    /*
     deleteItems Fonksiyonu
     deleteItems(offsets: IndexSet): Bu fonksiyon, kullanıcı listeden bir item silmek istediğinde çalışır. IndexSet, silinmek istenen öğelerin indeksini içerir.
     offsets.map { items[$0] }.forEach(viewContext.delete): Bu satır, silinmek istenen item'ları belirleyip viewContext.delete ile bu öğeleri veritabanından siler.
     Silme işlemi tamamlandığında, değişiklikler try viewContext.save() ile kaydedilir.
     */
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
        }
    }
    
    // MARK: - BODY
    
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: - MAIN VIEW
                VStack {
                    // MARK: - HEADER
                    HStack (spacing: 10) {
                        // TITLE
                            Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        // EDIT BUTTON
                        EditButton()
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        
                        // APPEARANCE BUTTON
                        Button (action: {
                            //TOGGLE APPEARANCE
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            feedback.notificationOccurred(.success)
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                    } //: HSTACK
                    .padding()
                    .foregroundColor(.white)
                    
                    
                    
                    Spacer(minLength: 80)
                    // MARK: - NEW TASK BUTTON
                    Button(action: {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        feedback.notificationOccurred(.success) //Başarı uyarı veya hata türünde geri bildirimler oluşturduk!
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: Color(red:0 , green: 0 , blue: 0, opacity: 0.25), radius: 8, x:0.0, y:4.0)
                    // MARK: - TASKS
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } //: LIST
                    .listStyle(InsetListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding()
                    .frame(maxWidth: 640) // Bu kod, varsayılan dikey dolguyu kaldıracak ve iPad aygıtlarında listeyi büyütecektir.
                } //: VSTACK
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .transition(.move(edge: .bottom))
                /*
                 .transition(.move(edge: .bottom))
                 .transition(.move(edge: .bottom)): Görünümün ekranda hareket ederek geçiş yapmasını sağlar.
                 .move(edge: .bottom): Geçişin nereden başlayacağını belirtir. Bu örnekte, geçiş alttan (bottom) yukarıya doğru gerçekleşir.
                 Görünüm, ekranda aşağıdan yukarıya hareket ederek görünür hale gelir veya kaybolur.

                 */
                .animation(.easeOut(duration: 0.5))
                // MARK: - NEW TASK ITEM
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ?  Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ?  0.3 : 0.5) //Arkada yarı saydam bir özellik oluşturduk!!
                        .onTapGesture {
                            showNewTaskItem = false
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            } //: ZSTACK
            .onAppear() { // Bu kod, tablo görünümünün arka plan rengini açık olarak ayarlayacaktır.
                UITableView.appearance().backgroundColor = UIColor.clear
            }
                .navigationBarTitle("Daily Task", displayMode: .large)
                .navigationBarHidden(true)
                //.toolbar {
                //    ToolbarItem(placement: .navigationBarTrailing) {
                //        EditButton()
                //    }
                    //     ToolbarItem(placement: .navigationBarTrailing)  -> BU kod a ihtiyaç bitti!
                    //     {
                    //         Button(action: addItem) {
                    //             Label("Add Item", systemImage: "plus")
                    //         }
                    //     }
                //} //: TOOLBAR
                .background(
                    BackgroundImageView()
                        .blur(radius: showNewTaskItem ? 8.0 : 0 , opaque: false)
                        
                )
                .background(
                    backgroundGradient.ignoresSafeArea(.all)
                )
            Text("Select an item")
        } //: NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle()) // Bu kod gezinti görünümünün bir seferde yalnızca tek bir sütun görünümü göstermesini sağlayacaktır!
    }

    
}

    // MARK: - PREVIEW
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
