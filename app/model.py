from .db import *

def get_user():
    return query_one("""
    SELECT * FROM "User";
    """)

def get_users_list_by_mask(mask):
    return query_all("""
        SELECT * FROM "User"
        WHERE "name" LIKE %(mask)s;
    """, mask = str(mask))

def get_chats_list():
	return query_all("""
		SELECT * FROM "Chat";
	""")

def get_members_list(user_id):
	return query_all("""
		SELECT topic FROM "Chat"
		JOIN "Member" ON "Chat".chat_id = "Member".chat_id
		AND user_id = %(user_id)s;
	""",
	user_id = user_id)

def add_new_chat(is_group_chat, topic, last_message):
	execute("""
		INSERT INTO "Chat" (is_group_chat, topic, last_message) VALUES (%(is_group_chat)s, %(topic)s, %(last_message)s);
	""",
	is_group_chat = str(is_group_chat),
	topic=str(topic),
	last_message = int(last_message))
	commit()

def add_new_message(chat_id, user_id, content, sent):
	execute("""
		INSERT INTO "Message" (chat_id, user_id, content, sent) VALUES (%(chat_id)s, %(user_id)s, %(content)s, %(sent)s);
		""",
		chat_id = int(chat_id), user_id = int(user_id), content = str(content), sent = sent
	)
	commit()

def get_messages(chat_id, user_id):
	return query_all("""
		SELECT content FROM "Message"
		WHERE chat_id = %(chat_id)s AND user_id = %(user_id)s;
		""", chat_id = int(chat_id), user_id = int(user_id))