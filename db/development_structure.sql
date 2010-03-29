CREATE TABLE authors ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar(255) DEFAULT NULL, "last_name" varchar(255) DEFAULT NULL);
CREATE TABLE authors_books ("author_id" integer NOT NULL, "book_id" integer NOT NULL);
CREATE TABLE books ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255) NOT NULL, "publisher_id" integer NOT NULL, "published_at" datetime DEFAULT NULL, "isbn" varchar(13) DEFAULT NULL, "blurb" text DEFAULT NULL, "page_count" integer DEFAULT NULL, "price" float DEFAULT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL, "photo_file_name" varchar(255), "photo_content_type" varchar(255), "photo_file_size" integer, "photo_updated_at" datetime);
CREATE TABLE publishers ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
CREATE TABLE schema_info (version integer);
INSERT INTO schema_info (version) VALUES (5)