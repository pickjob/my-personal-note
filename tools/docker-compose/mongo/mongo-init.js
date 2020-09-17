// db.auth('china', 'chinese');
db.createUser(
    {
        user: "china",
        pwd: "chinese",
        roles: [
            { role: "readWrite", db: "mongo" },
            { role: "dbAdmin", db: "mongo" }
        ]
    }
);