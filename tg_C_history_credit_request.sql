-- funcion del trigger de INSERT history_credit_request
CREATE OR REPLACE FUNCTION audit.f_tg_C_history_credit_request() RETURNS TRIGGER AS $tg_C_history_credit_request$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.history_credit_request
    (
			id_new,
			content_new,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.id,
			NEW.content,
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_history_credit_request$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - history_credit_request
CREATE TRIGGER tg_C_history_credit_request AFTER INSERT
ON cw.history_credit_request FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_history_credit_request();
