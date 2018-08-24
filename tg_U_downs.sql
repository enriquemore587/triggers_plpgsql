-- funcion del trigger de UPDATE downs
CREATE OR REPLACE FUNCTION audit.f_tg_U_downs() RETURNS TRIGGER AS $f_tg_U_downs$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.downs
    (
			user_id_new,
			reasons_id_new,
			commentary_new,
			active_new,
			date_action_new,
			id,
			responsible_user_id_new,
			user_id_old,
			reasons_id_old,
			commentary_old,
			active_old,
			date_action_old,
			responsible_user_id_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.user_id,
			NEW.reasons_id,
			NEW.commentary,
			NEW.active,
			NEW.date_action,
			NEW.id,
			NEW.responsible_user_id,
		
			OLD.user_id,
			OLD.reasons_id,
			OLD.commentary,
			OLD.active,
			OLD.date_action,
			OLD.responsible_user_id,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_downs$ LANGUAGE 'plpgsql';

-- trigger para UPDATE downs
CREATE TRIGGER tg_U_downs AFTER UPDATE
ON cw.downs FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_downs();