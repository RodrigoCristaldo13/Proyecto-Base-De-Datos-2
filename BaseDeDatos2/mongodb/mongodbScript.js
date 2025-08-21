use MongoDBEj7
db.createCollection("HistoricoConversaciones")
//mongo le setea un id a cada documento
db.HistoricoConversaciones.insertMany([
{
    "chat_id": 1,
    "fecha_chat": "2024-06-01T10:32:00",
    "inspectores": [
        {"id": 1, "nombre": "Fabricio Gimenez"},
        {"id": 2, "nombre": "Ana Monterroso"}
    ],
    "establecimiento": {
        "nombre": "Don Andrés",
        "direccion": "Av.Lucas Obes 1054, Montevideo",
        "telefono": "2336 6418"
    },
    "violacion": "Insectos en alimentos",
    "resultado": "Falla",
    "mensajes": [
        {
            //agregar hora para el contexto de un chat
            "inspector_id": 1, 
            "fecha_mensaje": "2024-06-01 10:32:00",
            "mensaje": "Encontramos insectos en los alimentos de 4 comensales."
        },
        {
            "inspector_id": 2,
            "fecha": "2024-06-01 10:35:00",
            "mensaje": "Tomaron fotos? Cuáles son las acciones a seguir?"
        },
        {
            "inspector_id": 1,
            "fecha": "2024-06-01 10:40:00",
            "mensaje": "Sí, tomamos fotos. Vamos a llamar a una empresa de control de plagas y desinfectar toda la cocina."
        }
    ]
},
{
        "chat_id": 2,
        "fecha_chat": "2024-06-02T14:47:00",
        "inspectores": [
            {"id": 3, "nombre": "Carlos Rodriguez"},
            {"id": 4, "nombre": "Lucia Fernandez"}
        ],
        "establecimiento": {
            "nombre": "El Fogón",
            "direccion": "S. José 1080, Montevideo",
            "telefono": "2900 0900"
        },
        "violacion": "Superficies sucias",
        "resultado": "Falla",
        "mensajes": [
            {
                "inspector_id": 3,
                "fecha_mensaje": "2024-06-02T14:47:00",
                "mensaje": "Las superficies de la cocina estaban sucias y grasientas."
            },
            {
                "inspector_id": 4,
                "fecha_mensaje": "2024-06-02T14:50:00",
                "mensaje": "Debemos limpiar y desinfectar las superficies. ¿Qué más se debe hacer?"
            },
            {
                "inspector_id": 3,
                "fecha_mensaje": "2024-06-02T14:55:00",
                "mensaje": "Reentrenar al personal de cocina sobre la limpieza adecuada."
            }
        ]
    },
    {
        "chat_id": 3,
        "fecha_chat": "2024-06-03T09:22:00",
        "inspectores": [
            {"id": 5, "nombre": "Mario Perez"},
            {"id": 6, "nombre": "Lucia Fernandez"}
        ],
        "establecimiento": {
            "nombre": "Carbonada",
            "direccion": "Francisco Joaquín Muñoz 3100, Montevideo",
            "telefono": "099 652 984"
        },
        "violacion": "Lavado de manos inadecuado",
        "resultado": "Falla",
        "mensajes": [
            {
                "inspector_id": 5,
                "fecha_mensaje": "2024-06-03T09:22:00",
                "mensaje": "El personal no seguía los procedimientos adecuados de lavado de manos."
            },
            {
                "inspector_id": 6,
                "fecha_mensaje": "2024-06-03T09:25:00",
                "mensaje": "¿Se instalarán más estaciones de lavado de manos?"
            },
            {
                "inspector_id": 5,
                "fecha_mensaje": "2024-06-03T09:30:00",
                "mensaje": "Sí, además se les dará capacitación adicional sobre higiene."
            }
        ]
    },
    {
        "chat_id": 4,
        "fecha_chat": "2024-06-03T09:22:00",
        "inspectores": [
            {"id": 7, "nombre": "Jose Pereyra"},
            {"id": 8, "nombre": "Rodrigo Martinez"}
        ],
        "establecimiento": {
            "nombre": "Pizzeria Ner York",
            "direccion": "José Enrique Rodó 5056, Canelones",
            "telefono": "4332 1807"
        },
        "violacion": "Lavado de manos inadecuado",
        "resultado": "Falla",
        "mensajes": [
            {
                "inspector_id": 7,
                "fecha_mensaje": "2024-06-03T09:22:00",
                "mensaje": "Detecté que los mozos no se lavaban las manos con frecuencia"
            },
            {
                "inspector_id": 8,
                "fecha_mensaje": "2024-06-03T09:25:00",
                "mensaje": "Entendido, cual fue su respuesta?"
            },
            {
                "inspector_id": 7,
                "fecha_mensaje": "2024-06-03T09:30:00",
                "mensaje": "No lo creían necesario, no tienen tiempo"
            }
        ]
    },
{
    "chat_id": 5,
    "fecha_chat": "2024-06-01T10:32:00",
    "inspectores": [
        {"id": 1, "nombre": "Fabricio Gimenez"},
        {"id": 6, "nombre": "Lucia Fernandez"}
    ],
    "establecimiento": {
        "nombre": "Centro Bar",
        "direccion": "25 de Mayo 551, San José",
        "telefono": "4343 0842"
    },
    "violacion": "Insectos en alimentos",
    "resultado": "Pasa",
    "mensajes": [
        {
            
            "inspector_id": 1, 
            "fecha_mensaje": "2024-06-01T10:32:00",
            "mensaje": "Hola! Encontramos una cantidad excesiva de insectos en las ensaladas"
        },
        {
            "inspector_id": 6,
            "fecha": "2024-06-01T10:35:00",
            "mensaje": "Bien! Se contactaron con el dueño del local y le explicaron los pasos a seguir?"
        },
        {
            "inspector_id": 1,
            "fecha": "2024-06-01T10:40:00",
            "mensaje": "Sí, fue muy comprensivo. Informamos sobre que acciones debe tomar el local y agendamos próxima inspección"
        }
    ]
    
},
{
    "chat_id": 6,
    "fecha_chat": "2024-06-01T10:32:00",
    "inspectores": [
        {"id": 1, "nombre": "Fabricio Gimenez"},
        {"id": 6, "nombre": "Lucia Fernandez"}
    ],
    "establecimiento": {
        "nombre": "Centro Bar",
        "direccion": "25 de Mayo 551, San José",
        "telefono": "4343 0842"
    },
    "violacion": "Insectos en alimentos",
    "resultado": "Pasa",
    "mensajes": [
        {
            
            "inspector_id": 1, 
            "fecha_mensaje": "2024-06-01T10:32:00",
            "mensaje": "Hola! Encontramos una cantidad excesiva de insectos en las ensaladas"
        },
        {
            "inspector_id": 6,
            "fecha": "2024-06-01T10:35:00",
            "mensaje": "Bien! Se contactaron con el dueño del local y le explicaron los pasos a seguir?"
        },
        {
            "inspector_id": 1,
            "fecha": "2024-06-01T10:40:00",
            "mensaje": "Sí, fue muy comprensivo. Informamos sobre que acciones debe tomar el local y agendamos próxima inspección"
        }
    ]
},
{
    "chat_id": 7,
    "fecha_chat": "2024-06-01T10:32:00",
    "inspectores": [
        {"id": 1, "nombre": "Fabricio Gimenez"},
        {"id": 6, "nombre": "Lucia Fernandez"}
    ],
    "establecimiento": {
        "nombre": "El Horno de Soca",
        "direccion": "25 de Mayo 551, San José",
        "telefono": "4343 0842"
    },
    "violacion": "Insectos en alimentos",
    "resultado": "Pasa",
    "mensajes": [
        {
            
            "inspector_id": 1, 
            "fecha_mensaje": "2024-06-01T10:32:00",
            "mensaje": "Hola! Encontramos una cantidad excesiva de insectos en las ensaladas"
        },
        {
            "inspector_id": 6,
            "fecha": "2024-06-01T10:35:00",
            "mensaje": "Bien! Se contactaron con el dueño del local y le explicaron los pasos a seguir?"
        },
        {
            "inspector_id": 1,
            "fecha": "2024-06-01T10:40:00",
            "mensaje": "Sí, fue muy comprensivo. Informamos sobre que acciones debe tomar el local y agendamos próxima inspección"
        }
    ]
}

]);
    
    
//Consultas:

//  a) Cuantas conversaciones sobre violaciones diferentes se constataron.

db.HistoricoConversaciones.distinct("violacion").length


//  b) Obtener los mejores establecimientos basado en la cantidad de inspecciones aprobadas.

db.HistoricoConversaciones.aggregate([
    {
        $match: {resultado: "Pasa"} //Filtra documentos
    },
    {
        $group: { //los que pasan agrupo
            _id: "$establecimiento.nombre",
            inspeccionesAprobadas:{ $sum: 1}
            }
        },
        {
            $sort:{inspeccionesAprobadas:-1} //desc por cantidad
        }
    ])

/*
El equivalente SQL:

SELECT establecimiento_Nombre, COUNT(*) AS inspecciones_Aprobadas
FROM Historico_Conversaciones
WHERE resultado = 'Pasa'
GROUP BY establecimiento_Nombre
ORDER BY inspecciones_Aprobadas DESC;
*/


    
/*
    c) Modificar una conversacion agregando una etiqueta "IMPORTANTE" para todos aquellos chats que tengan referencia a resultados reprobados('Falla').
    agrego un campo 'etiqueta' con el mensaje 'IMPORTANTE' solo en aquellos donde el resultado sea 'Falla'
*/

db.HistoricoConversaciones.updateMany(
    {resultado: "Falla"},
    {$set:{etiqueta:"IMPORTANTE"}});

//prueba: 
db.HistoricoConversaciones.find({etiqueta: "IMPORTANTE"});
   
