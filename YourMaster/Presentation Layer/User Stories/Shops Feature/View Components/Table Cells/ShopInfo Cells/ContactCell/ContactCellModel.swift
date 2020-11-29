

enum ContactType {
    case phoneNumber(number: String)
    case instagram(link: String)
    case webSite(link: String)
}

final class ContactCellModel: TableCellModel {

    override var cellIdentifier: String {
        return ContactCell.cellIdentifier
    }

    let contactType: ContactType
    
    init(contact: String) {
        if contact.contains("instagram") {
            self.contactType = .instagram(link: contact)
            return
        }
        self.contactType = .phoneNumber(number: contact)
    }
}
