import Socket
import Foundation

// Read command-line argumens
let port = CommandLine.arguments[1]
guard let port = Int(port) else{
        print("Wrong Port")
        exit(1)
    }

if (CommandLine.arguments.count) != 2{
    print("Error, try")
}
    //Fundamento de las comunicaciones, estamos usando udp
    //Con udp garantizamos que el paquete va a llegar a destino.
do{
    let serverSocket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
    try serverSocket.listen(on: port)
    print("Listening on \(port)")
    var buffer = Data(capacity: 1000)
    repeat {
    //si le pongo &, la funcion destino  puede modificar esa variable y la va a modificar metiendo los datos que lleguemn
        //Esto es una tupla con el numero d ebytes enviado por cliente y su direccion
        let (bytesRead, clientAddress) = try serverSocket.readDatagram(into: &buffer)
        //en el try se queda esperando a que lleguen datos
        if let address = clientAddress{
            let (clientHostname, clientPort) = Socket.hostnameAndPort(from: address)!
            print("Received length \(bytesRead) from \(clientHostname):\(clientPort)")
            // DEcodificar en utf-8
            //interpretar los numeros que vienen por el buffer ocmo si fuera una cadena de caracteres
            let message = String(decoding: buffer, as: UTF8.self)
            print("Message: \(message)")
        }
        buffer.removeAll()
        //repetimos en bucle infinito, solo para si hay un error, que s ecaptura fuera del bucle
    } while true
    
}catch let error{
    print("Connection error \(error)")
    
}

//cada vez que llegan datos, los decodifica y los guarda en el buffer.
//Tengo que borrar los datos cada evz que recivvo un mensaje porque si no peta