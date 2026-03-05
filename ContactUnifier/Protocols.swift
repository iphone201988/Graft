
protocol ServicesEvents {
    func createdList(listName: String, listDesc: String)
    func createdContact(info: NewContactInfo)
}

extension ServicesEvents {
    func createdList(listName: String, listDesc: String) {}
    func createdContact(info: NewContactInfo) {}
}
