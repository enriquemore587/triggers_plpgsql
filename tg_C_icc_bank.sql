-- funcion del trigger de INSERT icc_bank
CREATE OR REPLACE FUNCTION audit.f_tg_C_icc_bank() RETURNS TRIGGER AS $tg_C_icc_bank$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.icc_bank
    (
			id,
			icc_new,
			spending_new,
			free_new,
			bank_id_new,
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
			NEW.bank_id,
			user_name,
			'INSERT',
			now());
      RETURN NULL;
  END;

$tg_C_icc_bank$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - icc_bank
CREATE TRIGGER tg_C_icc_bank AFTER INSERT
ON cw.icc_bank FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_icc_bank();
