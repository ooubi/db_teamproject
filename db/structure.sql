CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "admin_users" ("user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "eval_users" ("user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "pdst_id" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "original_data_types" ("odt_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "schema_info" varchar DEFAULT '', "mapping_info" varchar DEFAULT '', "submit_id" varchar, "pdst_id" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "parsing_data_sequence_types" ("pdst_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "task_name" varchar, "submit_user_id" varchar, "season_info" varchar, "null_ratio" float DEFAULT 0.5, "period_info" varchar, "estimate_state" integer, "total_tuple_num" integer DEFAULT 0, "dup_tuple_num" integer DEFAULT 0, "odt_id" varchar, "eval_user_id" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "participates" ("submit_user_id" varchar, "task_id" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "submit_users" ("user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "eval_value" integer DEFAULT 50, "participate_id" varchar, "submit_id" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "submits" ("submit_user_id" varchar, "odt_id" varchar, "task_id" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "tasks" ("task_name" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "description" varchar DEFAULT '', "min_upload_period_hour" integer DEFAULT 24, "tdt_name" varchar, "tdt_schema_info" varchar, "participate_id" varchar, "submit_id" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login_id" varchar, "password" varchar, "name" varchar, "sex" varchar, "address" varchar DEFAULT '', "birthdate" date, "cellphone" varchar, "is_admin" boolean DEFAULT 'f', "is_eval" boolean DEFAULT 'f', "is_submit" boolean DEFAULT 'f', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO schema_migrations (version) VALUES ('20151104073114');

INSERT INTO schema_migrations (version) VALUES ('20151104073131');

INSERT INTO schema_migrations (version) VALUES ('20151104073138');

INSERT INTO schema_migrations (version) VALUES ('20151104073144');

INSERT INTO schema_migrations (version) VALUES ('20151104073150');

INSERT INTO schema_migrations (version) VALUES ('20151104073203');

INSERT INTO schema_migrations (version) VALUES ('20151104073216');

INSERT INTO schema_migrations (version) VALUES ('20151104073229');

INSERT INTO schema_migrations (version) VALUES ('20151104073234');

