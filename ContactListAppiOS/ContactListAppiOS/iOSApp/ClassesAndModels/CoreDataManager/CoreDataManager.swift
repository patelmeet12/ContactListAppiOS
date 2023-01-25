//
//  CoreDataManager.swift
//  ContactListAppiOS
//
//  Created by Meet Patel on 25/01/23.
//

import UIKit
import CoreData

struct CoreEntity {
    
    static let contacts = "Contacts"
}

struct CoreAttribute {
    
    static let name = "name"
    static let email = "email"
    static let countryCode = "countrycode"
    static let phoneno = "phoneno"
    static let image = "image"
}

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func insertContact(contact: Contact, completion: (_ isSuccess: Bool, _ message: String) -> Void) {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreEntity.contacts)
        request.predicate = NSPredicate(format: "\(CoreAttribute.countryCode) = %@ && \(CoreAttribute.phoneno) = %@", contact.countryCode, contact.telephone)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            if let _ = result.first {
                return
            }
        } catch {
            print("Error in insert data: \(error.localizedDescription)")
        }
        
        let conEntity = NSEntityDescription.entity(forEntityName: CoreEntity.contacts, in: context)
        let newContact = NSManagedObject(entity: conEntity!, insertInto: context)
        newContact.setValue((contact.firstName + " " + contact.lastName), forKey: CoreAttribute.name)
        newContact.setValue(contact.email, forKey: CoreAttribute.email)
        newContact.setValue(contact.countryCode, forKey: CoreAttribute.countryCode)
        newContact.setValue(contact.telephone, forKey: CoreAttribute.phoneno)
        newContact.setValue(contact.image?.jpegData(compressionQuality: 1), forKey:  CoreAttribute.image)
        
        do {
            try context.save()
            completion(true, "Contact Saved Successfully.")
        } catch {
            completion(false, error.localizedDescription)
        }
    }
    
    func getAllContacts() -> [Contact] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreEntity.contacts)
        request.returnsObjectsAsFaults = false
        
        var arrOfContacts = [Contact]()
        
        do {
            
            let result = try context.fetch(request)
            
            for r in result as! [NSManagedObject] {
                
                let name = r.value(forKey: CoreAttribute.name) as? String ?? ""
                let email = r.value(forKey: CoreAttribute.email)
                let coutryCode = r.value(forKey: CoreAttribute.countryCode) as? String ?? ""
                let phoneno = r.value(forKey: CoreAttribute.phoneno) as? String ?? ""
                let imagedata = r.value(forKey: CoreAttribute.image) as? Data ?? Data()
                
                let names = name.components(separatedBy: " ")
                
                arrOfContacts.append(Contact(contactId: r.objectID,
                                             image: UIImage(data: imagedata),
                                             firstName: names.first ?? "",
                                             lastName: names.last ?? "",
                                             email: (email as? String) ?? "",
                                             countryCode: coutryCode,
                                             telephone: phoneno))
            }
            
        } catch {
            print(error.localizedDescription)
        }
        return arrOfContacts
    }
    
    func updateContact(con: Contact, completion: (_ isSuccess: Bool, _ message: String) -> Void) {
        
        if let objID = con.contactId {
            
            do {
                
                let result = try context.existingObject(with: objID)
                
                result.setValue((con.firstName + " " + con.lastName), forKey: CoreAttribute.name)
                result.setValue(con.email, forKey: CoreAttribute.email)
                result.setValue(con.countryCode, forKey: CoreAttribute.countryCode)
                result.setValue(con.telephone, forKey: CoreAttribute.phoneno)
                result.setValue(con.image?.jpegData(compressionQuality: 1), forKey:  CoreAttribute.image)
                
                try context.save()
                completion(true, "Update contact successfullly!")
                
            } catch {
                completion(false, "Error in update data: \(error.localizedDescription)")
            }
        } else {
            completion(false, "Contact ObjectID not found, Please try again letter!")
        }
    }
}
