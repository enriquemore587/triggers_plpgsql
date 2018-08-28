-- funcion del trigger de INSERT ocr_files
CREATE OR REPLACE FUNCTION audit.f_tg_C_ocr_files() RETURNS TRIGGER AS $tg_C_ocr_files$
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
			user_name,
			'INSERT',
			now()
		);
      RETURN NULL;
  END;

$tg_C_ocr_files$ LANGUAGE 'plpgsql';



-- TRIGGER - INSERT  - ocr_files
CREATE TRIGGER tg_C_ocr_files AFTER INSERT
ON cw.ocr_files FOR EACH ROW
EXECUTE PROCEDURE audit.f_tg_C_ocr_files();
