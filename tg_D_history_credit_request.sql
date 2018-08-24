-- funcion del trigger de eliminar en la tabla cw.history_credit_request
CREATE OR REPLACE FUNCTION audit.f_tg_D_history_credit_request() RETURNS TRIGGER AS $f_tg_D_history_credit_request$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.history_credit_request
    (
			id_old,
			content_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			OLD.id,
			OLD.content,
			user_name,
			'DELETE',
			now()
		);
      RETURN NULL;
  END;

$f_tg_D_history_credit_request$ LANGUAGE 'plpgsql';

-- trigger para eliminar history_credit_request
CREATE TRIGGER tg_D_history_credit_request AFTER DELETE
ON cw.history_credit_request FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_history_credit_request();
