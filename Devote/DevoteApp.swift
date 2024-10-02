//
//  DevoteApp.swift
//  Devote
//
//  Created by gizem demirtas on 24.09.2024.
//

import SwiftUI

@main
struct DevoteApp: App {
    // Daha önce Persistence dosyasında tanımlanan PersistenceController sınıfının shared (singleton) örneği burada kullanılıyor.
    let persistenceController = PersistenceController.shared // Bu satır uygulamanın tüm yaşam döngüsü boyunca Core Data işlemlerini yönetecek olan persistent container a erişim sağlar. Bu sayede Core Data ile veri okuma yazma işlemleri sağlanır.
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false //ContentView dosyasına yazdığımız için yazdık! Kullanıcı uygulamayı koyu yada açık yapabilsin diye !!

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light) // Bu kod, cihazda genel olarak hangi görünümün ayarlandığına bakılmaksızın, bu uygulamanın tercih edilen renk düzenini bağımsız olarak ayarlayacaktır!
        }
        /*.environment(\.managedObjectContext, persistenceController.container.viewContext)
         Environment Modifiers (Çevre Değişkenleri): SwiftUI'da belirli veri türlerini view'lara geçmek için environment kullanılır. Burada kullanılan environment modifiyeri, SwiftUI'daki ContentView'e Core Data'nın managedObjectContext'ini geçiyor.

         managedObjectContext: Core Data'nın ana veri yönetim context'idir. Veritabanı işlemleri (ekleme, silme, güncelleme, sorgulama) bu context üzerinden yapılır.
         persistenceController.container.viewContext: Bu, Core Data'da veritabanı işlemlerini yapan ve UI'ı yöneten context'tir. Yani, burada Core Data'nın veri konteyneri (persistent container) SwiftUI ile paylaşılıyor ve UI'nın Core Data ile doğrudan çalışması sağlanıyor.
         Böylece, ContentView içinde Core Data ile çalışan bileşenler managedObjectContext'i kullanarak veritabanı işlemleri yapabilir. Bu, özellikle veri oluşturma, silme, güncelleme gibi işlemleri kolaylaştırır.

         Özet:
         Bu kod, SwiftUI uygulamasının başlangıç yapısını oluşturur. Core Data'yı kullanarak uygulamanın veritabanı işlemlerini yönetir ve SwiftUI ile entegre eder. PersistenceController aracılığıyla veritabanı işlemleri sağlanır ve ContentView'e Core Data'nın managedObjectContext'i environment üzerinden geçirilir. Bu sayede, SwiftUI'deki her bileşen, Core Data ile etkileşime girebilir.

         Bu mantıkla, uygulaman Core Data'yı kullanarak veritabanı işlemlerini yaparken SwiftUI üzerinden kullanıcı arayüzünde gösterim sağlanmış oluyor.*/
    }
}
