-- funcion del trigger de UPDATE users
CREATE OR REPLACE FUNCTION audit.f_tg_U_users() RETURNS TRIGGER AS $f_tg_U_users$
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
			id_profile_old,
			mail_old,
			pwd_old,
			registration_old,
			change_pwd_old,
			user_photo_old,
			num_client_old,
			mobile_phone_old,
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
		
			OLD.id_profile,
			OLD.mail,
			OLD.pwd,
			OLD.registration,
			OLD.change_pwd,
			OLD.user_photo,
			OLD.num_client,
			OLD.mobile_phone,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_users$ LANGUAGE 'plpgsql';

-- trigger para UPDATE users
CREATE TRIGGER tg_U_users AFTER UPDATE
ON cw.users FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_users();