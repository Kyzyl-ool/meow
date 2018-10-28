from .db import *

def get_user():
    return query_one("""
    SELECT * FROM "User";
    """)

def get_users_list_by_mask(mask):
    return query_all("""
        SELECT * FROM "User";
    """)
