-- funcion del trigger de UPDATE history_credit_request
CREATE OR REPLACE FUNCTION audit.f_tg_U_history_credit_request() RETURNS TRIGGER AS $f_tg_U_history_credit_request$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.history_credit_request
    (
			id_new,
			content_new,
			id_old,
			content_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.id,
			NEW.content,
			NEW.id,
			NEW.content,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_history_credit_request$ LANGUAGE 'plpgsql';

-- trigger para UPDATE history_credit_request
CREATE TRIGGER tg_U_history_credit_request AFTER UPDATE
ON cw.history_credit_request FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_history_credit_request();