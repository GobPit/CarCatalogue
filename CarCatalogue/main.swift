
import Foundation

/*
 - "year: 1998 brand: Nissan model: Terrano class: Crossover"
 - "year: 2002 brand: Toyota model: Corolla class: Sedan"
 - "year: 2006 brand: Mitsubishi model: L200 class: Pickup"

 */
var cars = ["year: 1998 brand: Nissan model: Terrano class: Crossover", "year: 2002 brand: Toyota model: Corolla class: Sedan", "year: 2006 brand: Mitsubishi model: L200 class: Pickup"]

func saveData() {
    UserDefaults.standard.set(cars, forKey: "carsDataKey")
    UserDefaults.standard.synchronize()
}

func loadData() {
    if let array = UserDefaults.standard.array(forKey: "carsDataKey") as? [String] {
        cars = array
    } else {
        cars = []
    }
}
loadData()


func listCars() -> () {
    dump(cars)
}

func addCars(newCar: String) -> (){
    print("""

    Enter new catalogue item or 'quit' to return
    Use next format: 'year:X brand:X model:X class:X'
    """)
    while let newCar = readLine() {
        guard newCar != "quit" else {
            break
        }
        cars.append(newCar)
        print("""
        Car '\(newCar)' is added
        
        Enter new catalogue item or 'quit' to return:
        """)
        saveData()
    }
}

func editCars() -> (){
    print("Enter line number to edit it or '0' to return")
    listCars()
    while let editCar = readLine() {
        let editItem = Int(editCar)!
        guard (editItem <= cars.count) && (editItem != 0) else {
            print("Catalogue contains \(cars.count) items. Enter correct line number")
            break
            }
        print("Editing Car '\(cars[editItem-1])'. Enter new information about this car")
        let lineNum = readLine()
        cars[editItem-1] = lineNum!
        print("""
        
        Enter new catalogue item or '0' to return:
        """)
        listCars()
        saveData()
    }
}

func delCars() -> (){
    print("Enter line number to delete it or '0' to return")
    listCars()
    while let delCar = readLine() {
        let delItem = Int(delCar)!
        guard (delItem <= cars.count) && (delItem != 0) else {
            print("Catalogue contains \(cars.count) items. Enter correct line number")
            break
            }
        print("Deleting Car '\(cars[delItem-1])'")
        cars.remove(at: (delItem-1))
        print("""
            
        Enter new catalogue item or '0' to return:
        """)
        listCars()
        saveData()
    }
}

let commandList: String = """

    Enter 'list' to get current list of the cars
    Enter 'add'  to add new car to the list
    Enter 'edit' to delete car from the list
    Enter 'del'  to delete car from the list
    Enter 'help' to get this command list
    Enter 'quit' to stop program

"""
print("""
    Welcome to our car catalogue!
    \(commandList)
    Enter your command:
    """)

while let input = readLine() {
    guard input != "quit" else {
        break
    }
    if input == "list" {
        listCars()
    } else if input == "add" {
        addCars(newCar: input)
    } else if input == "edit" {
        editCars()
    } else if input == "del" {
        delCars()
    } else if input == "help" {
        print(commandList)
    } else {
        print("Wrong command! Enter  help  to get command list")
    }
    print("")
    print("Enter your command: ")
}


