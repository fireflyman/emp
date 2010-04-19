CREATE TABLE authors ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar(255) DEFAULT NULL, "last_name" varchar(255) DEFAULT NULL);
CREATE TABLE authors_books ("author_id" integer NOT NULL, "book_id" integer NOT NULL);
CREATE TABLE books ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255) NOT NULL, "publisher_id" integer NOT NULL, "published_at" datetime DEFAULT NULL, "isbn" varchar(13) DEFAULT NULL, "blurb" text DEFAULT NULL, "page_count" integer DEFAULT NULL, "price" float DEFAULT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL, "photo_file_name" varchar(255), "photo_content_type" varchar(255), "photo_file_size" integer, "photo_updated_at" datetime);
CREATE TABLE cart_items ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "book_id" integer DEFAULT NULL, "cart_id" integer DEFAULT NULL, "price" float DEFAULT NULL, "amount" integer DEFAULT NULL, "created_at" datetime DEFAULT NULL);
CREATE TABLE carts ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
CREATE TABLE publishers ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "created_at" datetime DEFAULT NULL, "updated_at" datetime DEFAULT NULL);
CREATE TABLE schema_info (version integer);
CREATE TABLE taggings ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "tag_id" integer DEFAULT NULL, "taggable_id" integer DEFAULT NULL, "taggable_type" varchar(255) DEFAULT NULL, "created_at" datetime DEFAULT NULL);
CREATE TABLE tags ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) DEFAULT NULL);
CREATE INDEX "index_taggings_on_tag_id" ON taggings ("tag_id");
CREATE INDEX "index_taggings_on_taggable_id_and_taggable_type" ON taggings ("taggable_id", "taggable_type");
INSERT INTO schema_info (version) VALUES (8)