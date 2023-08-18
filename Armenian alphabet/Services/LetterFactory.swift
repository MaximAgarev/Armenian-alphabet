import Foundation

final class LetterFactory {
    
    private let dict = [["Ա", "ա", "а"],
                        ["Բ", "բ", "б"],
                        ["Գ", "գ", "г"],
                        ["Դ", "դ", "д"],
                        ["Ե", "ե", "е"],
                        ["Զ", "զ", "з"],
                        ["Է", "է", "э"],
                        ["Ը", "ը", "ы – э"],
                        ["Թ", "թ", "т"],
                        ["Ժ", "ժ", "ж"],
                        ["Ի", "ի", "и"],
                        ["Լ", "լ", "л"],
                        ["Խ", "խ", "х"],
                        ["Ծ", "ծ", "тц"],
                        ["Կ", "կ", "к"],
                        ["Հ", "հ", "h"],
                        ["Ձ", "ձ", "дз"],
                        ["Ղ", "ղ", "гх"],
                        ["Ճ", "ճ", "тч"],
                        ["Մ", "մ", "м"],
                        ["Յ", "յ", "й"],
                        ["Ն", "ն", "н"],
                        ["Շ", "շ", "ш"],
                        ["Ո", "ո", "во"],
                        ["Չ", "չ", "ч"],
                        ["Պ", "պ", "п"],
                        ["Ջ", "ջ", "дж"],
                        ["Ռ", "ռ", "р"],
                        ["Ս", "ս", "с"],
                        ["Վ", "վ", "в"],
                        ["Տ", "տ", "т"],
                        ["Ր", "ր", "р"],
                        ["Ց", "ց", "ц"],
                        ["Ւ", "ւ", "w"],
                        ["Փ", "փ", "п"],
                        ["Ք", "ք", "к"],
                        ["Եվ", "և", "ев"],
                        ["Օ", "օ", "о"],
                        ["Ֆ", "ֆ", "ф"]]
    
    func randomLetter() -> (String, String) {
        let letter = Int.random(in: 0 ..< dict.count)
        let isCapital = Bool.random()
        let armenian = dict[letter][isCapital ? 0 : 1]
        let russian = "[\(dict[letter][2])] \(isCapital ? "" : "малая")"
        
        return (armenian, russian)
    }
    
    func indexLetter(index: Int) -> [String] {
        return dict[index]
    }
    
    func count() -> Int {
        return dict.count
    }
}
