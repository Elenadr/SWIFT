import Socket
import Glibc

let server = "localhost"
//UN int 32 es un int de 32 bits

let port: Int32 = 7667
let message = "Hello, world"

do{
    //creamos una direcceion para este serves en el port
    //si no puede crear la dirección, devuelve nil
    // si no soy capaz d ecrear la direccion quiero acabar
    guard let serverAddress = Socket.createAddress(for: server, on: port) else {
        print("Error creating Address")
        //exit, es un 'truco' para salir, etá en la libreria glibc. EL uno es el código de salida
        exit(1)
    }
    //creamos la aprte del cliente de maner analoga al vservidor, el protocolo tine eque ser el mismo por que si no
    //no se van a entender
    //como es un socket de cliente nos asigna un puerto automatico
    let clientSocket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
    //Para escribir un mensaje, es más sencillo que el server, escribe en serverAddres, el mensaje que
    //hemos deficnido como una constante.
    try clientSocket.write(from: message, to: serverAddress)
} catch let error{
    print("Connection error: \(error)")
}
