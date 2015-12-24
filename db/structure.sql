CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "users" ("user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login_id" varchar, "password" varchar, "name" varchar, "sex" varchar, "address" varchar DEFAULT '', "birthdate" date, "cellphone" varchar, "score" integer DEFAULT 0, "is_admin" boolean DEFAULT 'f', "is_eval" boolean DEFAULT 'f', "is_submit" boolean DEFAULT 'f', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "admin_users" ("admin_user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "eval_users" ("eval_user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "submit_users" ("submit_user_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "tasks" ("task_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "task_name" varchar, "description" varchar DEFAULT '', "min_upload_period_hour" integer DEFAULT 24, "tdt_name" varchar, "tdt_schema_info" varchar, "active" boolean DEFAULT 't', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "original_data_types" ("odt_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "odt_name" varchar DEFAULT '', "schema_info" varchar DEFAULT '', "mapping_info" varchar DEFAULT '', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "submits" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "odf_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "participates" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "task_id" integer, "is_pending" boolean DEFAULT 't', "is_permitted" boolean DEFAULT 'f', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "original_data_files" ("odf_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "file" blob NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "parsing_data_sequence_files" ("pdsf_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "file" blob NOT NULL, "season_info" integer DEFAULT 1, "null_ratio" varchar DEFAULT '[]', "period_info" integer DEFAULT 1, "estimate_state" integer DEFAULT 0, "total_tuple_num" integer DEFAULT 0, "dup_tuple_num" integer DEFAULT 0, "is_assigned" boolean DEFAULT 'f', "is_evaluated" boolean DEFAULT 'f', "is_passed" boolean DEFAULT 'f', "score" integer DEFAULT 5, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "specifies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "odt_id" integer, "task_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "implement_odts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "odt_id" integer, "odf_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "converts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "odf_id" integer, "pdsf_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "evaluates" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "pdsf_id" integer, "is_pending" boolean DEFAULT 't', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "implement_tasks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "task_id" integer, "task_item_id" integer, "pdsf_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "task_tables" ("task_item_id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "item" varchar, "user_id" integer, "user_name" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO schema_migrations (version) VALUES ('20151104073114');

INSERT INTO schema_migrations (version) VALUES ('20151104073131');

INSERT INTO schema_migrations (version) VALUES ('20151104073138');

INSERT INTO schema_migrations (version) VALUES ('20151104073144');

INSERT INTO schema_migrations (version) VALUES ('20151104073150');

INSERT INTO schema_migrations (version) VALUES ('20151104073203');

INSERT INTO schema_migrations (version) VALUES ('20151104073229');

INSERT INTO schema_migrations (version) VALUES ('20151104073234');

INSERT INTO schema_migrations (version) VALUES ('20151124113233');

INSERT INTO schema_migrations (version) VALUES ('20151124113300');

INSERT INTO schema_migrations (version) VALUES ('20151124113343');

INSERT INTO schema_migrations (version) VALUES ('20151124113359');

INSERT INTO schema_migrations (version) VALUES ('20151124113414');

INSERT INTO schema_migrations (version) VALUES ('20151124131943');

INSERT INTO schema_migrations (version) VALUES ('20151202020455');

INSERT INTO schema_migrations (version) VALUES ('20151209013217');

