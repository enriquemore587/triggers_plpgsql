-- funcion del trigger de UPDATE ocr_files
CREATE OR REPLACE FUNCTION audit.f_tg_U_ocr_files() RETURNS TRIGGER AS $f_tg_U_ocr_files$
  DECLARE
  user_name VARCHAR(50);
  BEGIN
    select current_user into user_name;
    INSERT INTO audit.ocr_files
    (
			id,
			ocr_process_id_new,
			location_new,
			create_at_new,
			user_id_new,
			success_new,
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
			NEW.id,
			NEW.ocr_process_id,
			NEW.location,
			NEW.create_at,
			NEW.user_id,
			NEW.success,
			OLD.ocr_process_id,
			OLD.location,
			OLD.create_at,
			OLD.user_id,
			OLD.success,
			user_name,
			'UPDATE',
			now()
		);
      RETURN NULL;
  END;
$f_tg_U_ocr_files$ LANGUAGE 'plpgsql';

-- trigger para UPDATE ocr_files
CREATE TRIGGER tg_U_ocr_files AFTER UPDATE
ON cw.ocr_files FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_U_ocr_files();