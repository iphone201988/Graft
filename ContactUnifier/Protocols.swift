
protocol ServicesEvents {
    func createdList(listName: String, listDesc: String)
    func createdContact(info: NewAddingInfo)
    func createdLogInteraction(info: NewAddingInfo)
    func createdTag(info: NewAddingInfo)
}

extension ServicesEvents {
    func createdList(listName: String, listDesc: String) {}
    func createdContact(info: NewAddingInfo) {}
    func createdLogInteraction(info: NewAddingInfo) {}
    func createdTag(info: NewAddingInfo) {}
}
