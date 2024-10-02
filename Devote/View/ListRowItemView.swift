//
//  ListRowItemView.swift
//  Devote
//
//  Created by gizem demirtas on 1.10.2024.
//

import SwiftUI

struct ListRowItemView: View {
    // MARK: - PROPERTIES
    @Environment(\.managedObjectContext) var contextView //Bu sayfada CRUD işlemlerinden Update yapıyor!
    @ObservedObject var item: Item //Onay kutusunu gözlemleyen , yeniden çizen , kaydeden
    
    // MARK: - BODY
    var body: some View {
        // -> SwiftUI'da Toggle, bir boolean değeri (true/false) ile bağlı olan bir anahtarlama kontrolüdür ve genellikle bir şeyi açıp kapatmak için kullanılır.
        /*
         Toggle(isOn: $item.completion)
         Toggle: Bir düğme benzeri bir bileşendir ve açma/kapama (on/off) işlevi sağlar.
         isOn: Toggle'ın mevcut durumunu belirtir. $item.completion, bu duruma bağlanmış bir boolean değişkendir. $ işareti, burada two-way binding (çift yönlü veri bağlama) anlamına gelir, yani Toggle değiştiğinde item.completion da değişir.
         Eğer item.completion true ise Toggle açık (on) olur, false ise kapalı (off) olur.
         */
        
        Toggle(isOn: $item.completion){
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? Color.pink : Color.primary)
                .padding(.vertical, 12)
                .animation(.default)
        } //: TOGGLE
        .toggleStyle(CheckboxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            if self.contextView.hasChanges {
                try? self.contextView.save()
            }
        })
        /*
         1. .onReceive(item.objectWillChange, perform: { _ in ... })
         .onReceive: SwiftUI'da bir modifier'dır. Belirli bir Publisher'ı dinler ve o yayından (publisher) bir olay geldiğinde bir işlem (closure) gerçekleştirir. Bu olay genellikle bir veri değişikliği olduğunda tetiklenir.

         item.objectWillChange: Bu, bir yayındır (Publisher). item, muhtemelen bir ObservableObject türünde bir modeldir ve objectWillChange, bu modelin içinde herhangi bir değişiklik olduğunda yayına bir sinyal gönderir. Bu yayını dinleyerek, modelde değişiklik olduğunda bir işlem gerçekleştirilebiliyor.

         ObservableObject, SwiftUI'da veri modelini izlemek ve herhangi bir değişiklik olduğunda ilgili görünümleri (views) yeniden çizmek için kullanılır. objectWillChange, SwiftUI'ya bir modelin değişmek üzere olduğunu haber veren bir özelliktir.

         2. perform: { _ in ... }
         Bu, onReceive'in çalıştıracağı kod bloğunu temsil eder. objectWillChange sinyali alındığında bu blok çalıştırılır.
         _ in: Bu, yayından gelen verinin (örneğin hangi özelliğin değiştiği) kullanılmadığını belirtir. Eğer bu bilgiye ihtiyaç yoksa _ kullanılır.
         3. if self.contextView.hasChanges
         contextView, muhtemelen Core Data veya benzeri bir kalıcı veri yönetimi sistemiyle ilişkili bir NSManagedObjectContext'tir.
         hasChanges: Bu özellik, contextView içinde değişiklik yapılıp yapılmadığını kontrol eder. Yani veri bağlamında (örneğin bir veri modeli üzerinde) değişiklik yapılıp yapılmadığını belirtir. Eğer hasChanges true ise, veri bağlamında kaydedilmemiş değişiklikler vardır.
         4. try? self.contextView.save()
         save(): Core Data'da, yapılan değişiklikleri kalıcı olarak depolamak için kullanılan bir metottur. Eğer model üzerinde bir değişiklik yapılmışsa, bu metot bu değişiklikleri veritabanına kaydeder.
         try?: Bu, save() metodunun hata atabileceği anlamına gelir (örneğin kaydetme başarısız olursa bir hata fırlatır). Ancak burada try? kullanıldığı için, eğer bir hata oluşursa, bu hata göz ardı edilir ve hiçbir şey yapılmaz. Bu, kodun hata fırlatmadan güvenli bir şekilde devam etmesini sağlar.
         */
    }
}

  
