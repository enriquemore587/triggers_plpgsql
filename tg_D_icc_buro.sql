-- funcion del trigger de eliminar en la tabla cw.icc_buro
CREATE OR REPLACE FUNCTION audit.f_tg_D_icc_buro() RETURNS TRIGGER AS $f_tg_D_icc_buro$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.icc_buro
    (
			"id",
			icc_old,
			spending_old,
			free_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			OLD.id,
			OLD.icc,
			OLD.spending,
			OLD.free,
			user_name,
			'DELETE',
			now()
		);
    RETURN NULL;
  END;

$f_tg_D_icc_buro$ LANGUAGE 'plpgsql';

-- trigger para eliminar icc_buro
CREATE TRIGGER tg_D_icc_buro AFTER DELETE
ON cw.icc_buro FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_icc_buro();
