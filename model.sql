CREATE TABLE IF NOT EXISTS "users" (
	"id"	INTEGER NOT NULL UNIQUE,
	"user"	TEXT NOT NULL UNIQUE,
	"password"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "friendships" (
	"user1"	INTEGER NOT NULL,
	"user2"	INTEGER NOT NULL,
	"status"	INTEGER NOT NULL,
	PRIMARY KEY("user1","user2"),
	FOREIGN KEY("user2") REFERENCES "users"("id"),
	FOREIGN KEY("user1") REFERENCES "users"("id")
);
CREATE TABLE IF NOT EXISTS "list" (
	"id"	INTEGER NOT NULL UNIQUE,
	"owner"	INTEGER NOT NULL,
	"name"	TEXT NOT NULL,
	FOREIGN KEY("owner") REFERENCES "users"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "entry" (
	"id"	INTEGER NOT NULL UNIQUE,
	"title"	TEXT NOT NULL,
	"album"	TEXT NOT NULL,
	"artist"	TEXT NOT NULL,
	"link"	TEXT,
	"list"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("list") REFERENCES "list"("id")
);
CREATE TABLE IF NOT EXISTS "has_listened" (
	"title_id"	INTEGER NOT NULL,
	"user_id"	INTEGER NOT NULL,
	PRIMARY KEY("title_id", "user_id"),
	FOREIGN KEY("title_id") REFERENCES "title"("id"),
	FOREIGN KEY("user_id") REFERENCES "users"("id")
);