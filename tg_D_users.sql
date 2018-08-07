-- funcion del trigger de eliminar en la tabla cw.users
CREATE OR REPLACE FUNCTION audit.f_tg_D_users() RETURNS TRIGGER AS $f_tg_D_users$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.users
    (
			"id",
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
			OLD.id,
			OLD.id_profile,
			OLD.mail,
			OLD.pwd,
			OLD.registration,
			OLD.change_pwd,
			OLD.user_photo,
			OLD.num_client,
			OLD.mobile_phone,
			user_name,
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$f_tg_D_users$ LANGUAGE 'plpgsql';

-- trigger para eliminar user_activation_codes
CREATE TRIGGER tg_D_users AFTER DELETE
ON cw.users FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_users();
