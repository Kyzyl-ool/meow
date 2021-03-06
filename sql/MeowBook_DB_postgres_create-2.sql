ALTER TABLE "Member" DROP CONSTRAINT IF EXISTS "Member_fk0";

ALTER TABLE "Member" DROP CONSTRAINT IF EXISTS "Member_fk1";

ALTER TABLE "Member" DROP CONSTRAINT IF EXISTS "Member_fk2";

ALTER TABLE "Message" DROP CONSTRAINT IF EXISTS "Message_fk0";

ALTER TABLE "Message" DROP CONSTRAINT IF EXISTS "Message_fk1";

ALTER TABLE "Chat" DROP CONSTRAINT IF EXISTS "Chat_fk0";

ALTER TABLE "Attachment" DROP CONSTRAINT IF EXISTS "Attachment_fk0";

ALTER TABLE "Attachment" DROP CONSTRAINT IF EXISTS "Attachment_fk1";

ALTER TABLE "Attachment" DROP CONSTRAINT IF EXISTS "Attachment_fk2";

DROP TABLE IF EXISTS "User";

DROP TABLE IF EXISTS "Member";

DROP TABLE IF EXISTS "Message";

DROP TABLE IF EXISTS "Chat";

DROP TABLE IF EXISTS "Attachment";



CREATE TABLE "User" (
	"user_id" serial NOT NULL,
	"name" text NOT NULL,
	"nick" text NOT NULL UNIQUE,
	CONSTRAINT User_pk PRIMARY KEY ("user_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Member" (
	"user_id" serial NOT NULL,
	"chat_id" serial NOT NULL,
	"last_unread_message_id" serial,
	"member_id" serial NOT NULL,
	CONSTRAINT Member_pk PRIMARY KEY ("member_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Message" (
	"message_id" serial NOT NULL,
	"chat_id" serial NOT NULL,
	"user_id" serial NOT NULL,
	"content" text NOT NULL,
	"sent" timestamp NOT NULL,
	CONSTRAINT Message_pk PRIMARY KEY ("message_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Chat" (
	"chat_id" serial NOT NULL,
	"is_group_chat" bool NOT NULL,
	"topic" text NOT NULL,
	"last_message" serial,
	CONSTRAINT Chat_pk PRIMARY KEY ("chat_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE "Attachment" (
	"attach_id" serial NOT NULL,
	"chat_id" serial NOT NULL,
	"user_id" serial NOT NULL,
	"message_id" serial NOT NULL,
	"type" text NOT NULL,
	"url" text NOT NULL,
	"size" serial NOT NULL,
	CONSTRAINT Attachment_pk PRIMARY KEY ("attach_id")
) WITH (
  OIDS=FALSE
);




ALTER TABLE "Member" ADD CONSTRAINT "Member_fk0" FOREIGN KEY ("user_id") REFERENCES "User"("user_id");
ALTER TABLE "Member" ADD CONSTRAINT "Member_fk1" FOREIGN KEY ("chat_id") REFERENCES "Chat"("chat_id");
ALTER TABLE "Member" ADD CONSTRAINT "Member_fk2" FOREIGN KEY ("last_unread_message_id") REFERENCES "Message"("message_id");

ALTER TABLE "Message" ADD CONSTRAINT "Message_fk0" FOREIGN KEY ("chat_id") REFERENCES "Chat"("chat_id");
ALTER TABLE "Message" ADD CONSTRAINT "Message_fk1" FOREIGN KEY ("user_id") REFERENCES "User"("user_id");

ALTER TABLE "Chat" ADD CONSTRAINT "Chat_fk0" FOREIGN KEY ("last_message") REFERENCES "Message"("message_id");

ALTER TABLE "Attachment" ADD CONSTRAINT "Attachment_fk0" FOREIGN KEY ("chat_id") REFERENCES "Chat"("chat_id");
ALTER TABLE "Attachment" ADD CONSTRAINT "Attachment_fk1" FOREIGN KEY ("user_id") REFERENCES "User"("user_id");
ALTER TABLE "Attachment" ADD CONSTRAINT "Attachment_fk2" FOREIGN KEY ("message_id") REFERENCES "Message"("message_id");

alter table "Chat" alter last_message drop not null;
alter table "Member" alter last_unread_message_id drop not null;




DELETE FROM "Chat";
DELETE FROM "User";
DELETE FROM "Message";
DELETE FROM "Member";

INSERT INTO "User" VALUES (0, 'TestUser', 'TestNickname');
INSERT INTO "Chat" VALUES (0, TRUE, 'Sample topic', NULL);
INSERT INTO "Message" VALUES (0, 0, 0, 'Hello', '2018-11-11 11:11:11');
INSERT INTO "Member" VALUES (0, 0, 0, 1);


