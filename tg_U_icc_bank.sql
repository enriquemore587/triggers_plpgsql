-- funcion del trigger de UPDATE icc_bank
CREATE OR REPLACE FUNCTION audit.f_tg_U_icc_bank() RETURNS TRIGGER AS $f_tg_U_icc_bank$
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
			icc_old,
			spending_old,
			free_old,
			bank_id_old,
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
			OLD.icc,
			OLD.spending,
			OLD.free,
			OLD.bank_id,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_icc_bank$ LANGUAGE 'plpgsql';

-- trigger para UPDATE icc_bank
CREATE TRIGGER tg_U_icc_bank AFTER UPDATE
ON cw.icc_bank FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_icc_bank();