# MongoDB学习
```javascript
// CRUD
// query
db.collection.find()
// { <field1>: <value1>, ... }
db.inventory.find( { status: "D" } )
// { <field1>: { <operator1>: <value1> }, ... }
db.inventory.find( { status: { $in: [ "A", "D" ] } } )
db.inventory.find( { $or: [ { status: "A" }, { qty: { $lt: 30 } } ] } )
db.inventory.find( { "size.uom": "in" } )
db.inventory.find( { tags: { $all: ["red", "blank"] } } )
db.inventory.find( { "instock": { $elemMatch: { qty: 5, warehouse: "A" } } } )
db.inventory.find( { item: null } )
var myCursor = db.users.find( { type: 2 } );
while (myCursor.hasNext()) {
   print(tojson(myCursor.next()));
}
// insert
db.collection.insertOne()
db.collection.insertMany()
db.collection.insert()
// update
db.collection.updateOne()
db.collection.updateMany()
db.collection.update()
db.collection.replaceOne()
// delete
db.collection.deleteOne()
db.collection.deleteMany()
// db adminstration: db index user
use myNewDB
db.collection.createIndex( { name: -1 } )
db.products.createIndex(
  { item: 1, quantity: -1 } ,
  { name: "query for inventory" }
)
db.reviews.createIndex( { comments: "text" } )
db.reviews.createIndex(
   {
     subject: "text",
     comments: "text"
   }
)
use test
db.createUser(
  {
    user: "myTester",
    pwd:  passwordPrompt(),   // or cleartext password
    roles: [ { role: "readWrite", db: "test" },
             { role: "read", db: "reporting" } ]
  }
)
// build-in roles
//    read
//    readWrite
//    dbAdmin
//    userAdmin
//    dbOwner: readWrite + dbAdmin + userAdmin
```