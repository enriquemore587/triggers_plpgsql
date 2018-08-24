-- funcion del trigger de eliminar en la tabla cw.downs
CREATE OR REPLACE FUNCTION audit.f_tg_D_downs() RETURNS TRIGGER AS $f_tg_D_downs$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.downs
    (
			id,
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
			OLD.id,
			OLD.user_id,
			OLD.reasons_id,
			OLD.commentary,
			OLD.active,
			OLD.date_action,
			OLD.responsible_user_id,
			user_name,
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$f_tg_D_downs$ LANGUAGE 'plpgsql';

-- trigger para eliminar downs
CREATE TRIGGER tg_D_downs AFTER DELETE
ON cw.downs FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_downs();
