-- funcion del trigger de UPDATE icc_buro
CREATE OR REPLACE FUNCTION audit.f_tg_U_icc_buro() RETURNS TRIGGER AS $f_tg_U_icc_buro$
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
			icc_old,
			spending_old,
			free_old,
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
			OLD.icc,
			OLD.spending,
			OLD.free,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_icc_buro$ LANGUAGE 'plpgsql';

-- trigger para UPDATE icc_buro
CREATE TRIGGER tg_U_icc_buro AFTER UPDATE
ON cw.icc_buro FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_icc_buro();