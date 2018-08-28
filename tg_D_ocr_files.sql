-- funcion del trigger de eliminar en la tabla cw.ocr_files
CREATE OR REPLACE FUNCTION audit.f_tg_D_ocr_files() RETURNS TRIGGER AS $f_tg_D_ocr_files$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.ocr_files
    (
			"id",
			ocr_process_id_old,
			location_old,
			create_at_old,
			user_id_old,
			success_old,
			user_name,
			action_performed,
			date_action
		)
    VALUES
    (
			OLD.id,
			OLD.ocr_process_id,
			OLD.location,
			OLD.create_at,
			OLD.user_id,
			OLD.success,
			user_name,
			'INSERT',
			now()
		);
    RETURN NULL;
  END;

$f_tg_D_ocr_files$ LANGUAGE 'plpgsql';

-- trigger para eliminar ocr_files
CREATE TRIGGER tg_D_ocr_files AFTER DELETE
ON cw.ocr_files FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_D_ocr_files();
