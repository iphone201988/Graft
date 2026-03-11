
protocol ServicesEvents {
    func createdList(listName: String, listDesc: String)
    func createdContact(info: NewContactInfo)
    func createdLogInteraction(info: NewInteraction)
}

extension ServicesEvents {
    func createdList(listName: String, listDesc: String) {}
    func createdContact(info: NewContactInfo) {}
    func createdLogInteraction(info: NewInteraction) {}
}
