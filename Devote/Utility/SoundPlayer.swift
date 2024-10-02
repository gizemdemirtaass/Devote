//
//  SoundPlayer.swift
//  Devote
//
//  Created by gizem demirtas on 2.10.2024.
//

import Foundation
import AVFoundation


var audioPlayer: AVAudioPlayer?

//Bir ses efekti çalmak istediğimizde her seferinde çalışacak yeni bir fonksiyon oluşturacağız!

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }
        catch {
            print("Could not find and play the sound file")
        }
    }
}

/*
 Bu Swift kodu, iOS uygulamalarında bir ses dosyasını oynatmak için kullanılan AVFoundation çerçevesi aracılığıyla basit bir ses çalma fonksiyonu tanımlar. Şimdi kodun her bir kısmını detaylıca açıklayalım.

 1. import Foundation ve import AVFoundation
 import Foundation: Swift dilinde temel işlevler, veri türleri ve diğer standart kütüphaneleri kullanmak için gereklidir.
 import AVFoundation: Bu kütüphane, ses ve video işleme için kullanılan Apple'ın ses ve video çerçevesidir. Burada ses dosyalarını oynatmak için kullanılacaktır.
 2. var audioPlayer: AVAudioPlayer?
 AVAudioPlayer: Apple’ın ses dosyalarını oynatmak için sağladığı bir sınıftır. Bu sınıf, ses dosyalarını yüklemek, kontrol etmek ve çalmak gibi işlevleri yerine getirir.
 audioPlayer?: Bu bir opsiyonel (Optional) değişkendir, yani bu değişken nil olabileceği gibi bir AVAudioPlayer nesnesini de tutabilir. Ses dosyası başarıyla yüklendiğinde bu değişkene atanır ve kullanılır.
 3. func playSound(sound: String, type: String)
 Bu fonksiyon, iki parametre alır:
 sound: String: Ses dosyasının ismi (dosya adı).
 type: String: Ses dosyasının türü veya uzantısı (örneğin, "mp3", "wav").
 4. if let path = Bundle.main.path(forResource: sound, ofType: type)
 Bundle.main.path(forResource: ofType:): Uygulamanın ana bundle'ındaki (kaynaklarındaki) ses dosyasının yolunu bulmak için kullanılır. Bu, uygulamanın içerisinde bulunan bir dosyanın tam yolunu elde etmeye yarar.
 if let path =: Bu, bir opsiyonel bağlama işlemidir. Bundle.main.path(...) fonksiyonu bir string döndürebilir veya nil dönebilir. Eğer ses dosyası bulunduysa, yol (path) değişkenine atanır ve if bloğu çalışır; aksi takdirde ses dosyası bulunmadığı için nil döner ve işlem yapılmaz.
 5. do { ... } catch { ... }
 do { ... } catch { ... }: Bu yapı, hataya açık (error-prone) kod bloklarını yönetmek için kullanılır. try ile birlikte kullanılır. Eğer try ifadesinde bir hata oluşursa, catch bloğu devreye girer ve hatayı yakalar.
 6. audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
 AVAudioPlayer(contentsOf: URL): Bu, belirli bir dosya yolunu kullanarak bir ses oynatıcı nesnesi oluşturur.
 URL(fileURLWithPath: path): Dosya yolunu URL formatına çevirir. AVAudioPlayer, ses dosyasını çalabilmek için URL formatında bir yol bekler.
 try: Bu ifade, AVAudioPlayer oluşturma işleminin hata fırlatma olasılığı olduğu için kullanılır. Yani eğer dosya yolu geçersizse ya da dosya oynatılamıyorsa bir hata oluşacaktır.
 Eğer ses dosyası başarıyla yüklenirse, bu nesne audioPlayer değişkenine atanır.
 7. audioPlayer?.play()
 Eğer audioPlayer başarıyla oluşturulmuşsa (nil değilse), bu fonksiyon ses dosyasını çalmaya başlar.
 8. catch { print("Could not find and play the sound file") }
 Eğer yukarıdaki try ifadesi bir hata fırlatırsa, bu blok devreye girer ve konsola "Could not find and play the sound file" yazdırılır. Yani dosya bulunmazsa ya da başka bir hata oluşursa, bu mesaj görünür.
 Özet Fonksiyonun İşleyişi:
 Ses dosyasının yolunu bulmak için Bundle.main.path(forResource:ofType:) kullanılır.
 AVAudioPlayer kullanarak bu dosya yüklenir.
 Eğer dosya başarıyla yüklendiyse, audioPlayer üzerinden ses dosyası çalınır.
 Eğer herhangi bir hata oluşursa, hata mesajı konsola yazdırılır.
 */
