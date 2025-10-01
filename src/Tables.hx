package;

import externals.pydal.Field;
import externals.pydal.DAL;


class Tables {
    public static function defineTables(db:DAL) {
        db.define_table(
            "user",
            new Field("login_name"),
            new Field("nicename"),
            new Field("email"),
            new Field("password"),
            new Field("phone"),
            new Field("avatar"),
            new Field("gender"),
            new Field("is_super", "boolean"),
            new Field("created_at", "datetime"),
            new Field("updated_at", "datetime"),
            new Field("deleted_at", "datetime")
        );

        db.define_table(
            "school",
            new Field("name")
        );

        db.define_table(
            "as_list", // Amour Secret list
            new Field("self_userid", "bigint"),
            new Field("target_userid", "bigint"),
            new Field("school_id", "bigint")
        );

        db.define_table(
            "user_school_relation",
            new Field("user_id", "bigint"),
            new Field("school_id", "bigint")
        );

        db.define_table(
            "user_related_school",
            new Field("relation_id", "bigint"),
            new Field("user_id", "bigint"),
            new Field("school_id", "bigint"),
            new Field("name"),
            new Field("user_nicename"),
            new Field("user_loginname")
        );

        db.define_table(
            "as_list_with_details",
            new Field("target_userid", "bigint"),
            new Field("self_userid", "bigint"),
            new Field("target_user_nicename"),
            new Field("target_user_login_name"),
            new Field("school_id", "bigint"),
            new Field("school_name")
        );
    }
}
