-- funcion del trigger de INSERT USERS
CREATE OR REPLACE FUNCTION audit.f_tg_C_users() RETURNS TRIGGER AS $tg_C_users$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.users
    (
			id,
			id_profile_new,
			mail_new,
			pwd_new,
			registration_new,
			change_pwd_new,
			user_photo_new,
			num_client_new,
			mobile_phone_new,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.id, 
			NEW.id_profile, 
			NEW.mail, 
			NEW.pwd, 
			NEW.registration, 
			NEW.change_pwd, 
			NEW.user_photo, 
			NEW.num_client, 
			NEW.mobile_phone,
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_users$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - USERS
CREATE TRIGGER tg_C_users AFTER INSERT
ON cw.users FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_users();
