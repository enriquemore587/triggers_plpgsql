-- funcion del trigger de INSERT icc_buro
CREATE OR REPLACE FUNCTION audit.f_tg_C_icc_buro() RETURNS TRIGGER AS $tg_C_icc_buro$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.icc_buro
    (
			id,
			icc_new,
			spending_new,
			free_new,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			NEW.id,
			NEW.icc,
			NEW.spending,
			NEW.free,
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_icc_buro$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - icc_buro
CREATE TRIGGER tg_C_icc_buro AFTER INSERT
ON cw.icc_buro FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_icc_buro();
