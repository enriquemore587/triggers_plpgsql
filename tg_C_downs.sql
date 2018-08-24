-- funcion del trigger de INSERT downs
CREATE OR REPLACE FUNCTION audit.f_tg_C_downs() RETURNS TRIGGER AS $tg_C_downs$
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
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_downs$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - downs
CREATE TRIGGER tg_C_downs AFTER INSERT
ON cw.downs FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_downs();
